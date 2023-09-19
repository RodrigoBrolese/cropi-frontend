part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AuthenticateAppEvent extends AppEvent {
  const AuthenticateAppEvent({required this.user});

  final User user;
}

class OpenAppEvent extends AppEvent {
  const OpenAppEvent();
}

class LogoutAppEvent extends AppEvent {
  const LogoutAppEvent();
}

class SetViewedNotificationAppEvent extends AppEvent {
  const SetViewedNotificationAppEvent();
}
