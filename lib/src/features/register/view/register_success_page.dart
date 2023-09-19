import 'package:cropi/src/features/register/widgets/widgets.dart';
import 'package:cropi/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cropi/src/features/register/bloc/bloc.dart';

class RegisterSuccessPage extends StatelessWidget {
  const RegisterSuccessPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
        builder: (_) => const RegisterSuccessPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: const Scaffold(
        body: RegisterSuccessView(),
      ),
    );
  }
}

class RegisterSuccessView extends StatelessWidget {
  const RegisterSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleLayout(
        title: 'Conta criada com sucesso', body: RegisterSuccessBody());
  }
}
