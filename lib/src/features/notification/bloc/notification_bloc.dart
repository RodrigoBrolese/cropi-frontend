import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cropi/src/services/api/api.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationInitial()) {
    on<LoadNotificationEvent>(_onLoadNotificationEvent);
  }

  FutureOr<void> _onLoadNotificationEvent(
    LoadNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    var response = await GetIt.I<ApiClient>().get("/user/notification");

    if (response.statusCode != 200) {
      emit(const NotificationLoaded(notifications: []));
    }
    List<dynamic> notifications = GetIt.I<ApiClient>()
        .bodyToJson(response)['notifications'] as List<dynamic>;

    emit(NotificationLoaded(notifications: notifications));
  }
}
