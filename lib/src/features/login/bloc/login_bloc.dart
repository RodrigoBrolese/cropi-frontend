import 'dart:async';
import 'dart:convert';

import 'package:cropi/src/app/bloc/bloc.dart';
import 'package:cropi/src/models/models.dart';
import 'package:cropi/src/services/api/api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LoginUserEvent>(_onLoginEvent);
    on<LoginCheckEvent>(_onLoginCheckEvent);
  }

  FutureOr<void> _onLoginEvent(
    LoginUserEvent event,
    Emitter<LoginState> emit,
  ) async {
    ApiClient apiClient = GetIt.instance<ApiClient>();

    await apiClient.post('/login', body: {
      'email': event.email,
      'password': event.password,
    }).then((response) async {
      if (response.statusCode != 200) {
        event.onEnd(null);
        emit(const LoginErrorState(message: "E-mail ou senha incorretos"));
        return;
      }

      var json = jsonDecode(response.body);

      apiClient.setAuthToken(json['token']);

      User user = await _loginUser(json['token'], apiClient);

      event.onEnd(user);
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      event.onEnd(null);
      emit(const LoginErrorState(message: "Ocorreu um erro desconhecido"));
    });
  }

  FutureOr<void> _onLoginCheckEvent(
      LoginCheckEvent event, Emitter<LoginState> emit) async {
    ApiClient apiClient = GetIt.instance<ApiClient>();

    if (!await apiClient.check()) {
      if (kDebugMode) {
        print("no server connection");
      }
      emit(const LoginErrorState(
          message:
              "Verifique sua conexão com a internet ou tente novamente mais tarde"));
      return;
    }

    await GetIt.I.isReady<SharedPreferences>();
    String? token = GetIt.I<SharedPreferences>().getString('token');

    if (token == null) {
      emit(const LoginRequestState());
      return;
    }

    apiClient.setAuthToken(token);

    try {
      User user = await _loginUser(token, apiClient);

      if (event.context.mounted) {
        // ignore: use_build_context_synchronously
        event.context.read<AppBloc>().add(AuthenticateAppEvent(user: user));
        // ignore: use_build_context_synchronously
        event.context.goNamed('home');
      }
    } catch (e) {
      emit(const LoginErrorState(message: "Faça o login novamente"));
    }
  }

  Future<User> _loginUser(String token, ApiClient apiClient) async {
    var userResponse = jsonDecode((await apiClient.get('/user')).body)['user'];

    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        var firebaseToken = await GetIt.I<FirebaseMessaging>().getToken();

        if (firebaseToken != null) {
          apiClient.post('/user/notification-token', body: {
            'notification_token': firebaseToken,
          });

          GetIt.I<FirebaseMessaging>().onTokenRefresh.listen((event) {
            apiClient.post('/user/notification-token', body: {
              'notification_token': event,
            });
          });

          _configureAndroid();
        }
      }
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }

    User user = User.fromJson({
      'id': userResponse['id'],
      'name': userResponse['name'],
      'email': userResponse['email'],
      'bornDate': userResponse['born_date'],
      'authToken': token,
      'hasUnviewedNotifications':
          userResponse['has_unviewed_notifications'] ?? false,
      'rememberToken': 'todo',
    });

    GetIt.I<SharedPreferences>().setString(
      'token',
      token,
    );

    return user;
  }

  void _configureAndroid() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'Notifications',
      importance: Importance.max,
      playSound: true,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification == null || android == null) {
          return;
        }

        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();

        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              playSound: true,
              icon: const AndroidInitializationSettings('@mipmap/ic_launcher')
                  .defaultIcon,
            ),
          ),
        );
      },
    );
  }
}
