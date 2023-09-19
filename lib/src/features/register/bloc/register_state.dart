part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.name = '',
    this.email = '',
    this.bornDate,
    this.password = '',
    this.confirmPassword = '',
  });

  final String name;
  final String email;
  final DateTime? bornDate;
  final String password;
  final String confirmPassword;

  @override
  List<Object> get props =>
      [name, email, bornDate ?? '', password, confirmPassword];

  RegisterState copyWith({
    String? name,
    String? email,
    DateTime? bornDate,
    String? password,
    String? confirmPassword,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      bornDate: bornDate ?? this.bornDate,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}

class RegisterInitial extends RegisterState {
  const RegisterInitial() : super();
}

class RegisterSuccessState extends RegisterState {
  const RegisterSuccessState() : super();
}

class RegisterErrorState extends RegisterState {
  const RegisterErrorState({
    required this.message,
    super.name,
    super.email,
    super.bornDate,
    this.errorEmail = '',
  }) : super();

  final String message;
  final String errorEmail;
}
