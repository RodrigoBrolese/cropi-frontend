part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];

  LoginState copyWith({
    String? email,
    String? password,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class LoginInitial extends LoginState {
  const LoginInitial() : super();
}

class LoginErrorState extends LoginState {
  const LoginErrorState({required this.message}) : super();

  final String message;
}

class LoginRequestState extends LoginState {
  const LoginRequestState() : super();
}

class LoginSuccessState extends LoginState {
  const LoginSuccessState({required this.user}) : super();

  final User user;
}
