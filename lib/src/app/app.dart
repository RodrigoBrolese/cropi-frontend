import 'package:cropi/src/app/bloc/bloc.dart';
import 'package:cropi/src/app/color/color_schemes.g.dart';
import 'package:cropi/src/app/router.dart';
import 'package:cropi/src/services/api/api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  const App({super.key});

  void _setup(BuildContext context) {
    final getIt = GetIt.instance;

    if (!getIt.isRegistered<SharedPreferences>()) {
      getIt.registerLazySingletonAsync<SharedPreferences>(
          () async => await SharedPreferences.getInstance());
    }
    if (!getIt.isRegistered<ApiClient>()) {
      getIt.registerSingleton<ApiClient>(
          ApiClient(domain: dotenv.get('API_DOMAIN')));
    }
    if (!getIt.isRegistered<FirebaseMessaging>()) {
      getIt.registerSingleton<FirebaseMessaging>(FirebaseMessaging.instance);
    }
  }

  @override
  Widget build(BuildContext context) {
    _setup(context);
    return BlocProvider(
        create: (BuildContext context) {
          return AppBloc();
        },
        child: const _MaterialApp());
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
