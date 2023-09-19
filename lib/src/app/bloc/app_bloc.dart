import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cropi/src/models/models.dart';
import 'package:cropi/src/services/api/api.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppInitial()) {
    on<AuthenticateAppEvent>(_onAuthenticateAppEvent);
    on<OpenAppEvent>(_onOpenAppEvent);
    on<LogoutAppEvent>(_onLogoutAppEvent);
    on<SetViewedNotificationAppEvent>(_onSetViewedNotificationAppEvent);
  }

  FutureOr<void> _onAuthenticateAppEvent(
    AuthenticateAppEvent event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(user: event.user));
  }

  FutureOr<void> _onOpenAppEvent(
    OpenAppEvent event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(user: null));
  }

  FutureOr<void> _onLogoutAppEvent(
    LogoutAppEvent event,
    Emitter<AppState> emit,
  ) {
    GetIt.I<SharedPreferences>().remove('token');
    GetIt.I<ApiClient>().logout();
    emit(state.copyWith(user: null));
  }

  FutureOr<void> _onSetViewedNotificationAppEvent(
      SetViewedNotificationAppEvent event, Emitter<AppState> emit) {
    User? user = state.user;
    if (user != null) {
      user = user.copyWith(hasUnviewedNotifications: false);
      emit(state.copyWith(user: user));
    }
  }
}
