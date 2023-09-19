part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUserEvent extends LoginEvent {
  const LoginUserEvent(
      {required this.email, required this.password, required this.onEnd});

  final String email;
  final String password;
  final Function(User?) onEnd;
}

class LoginCheckEvent extends LoginEvent {
  const LoginCheckEvent(this.context);

  final BuildContext context;
}
