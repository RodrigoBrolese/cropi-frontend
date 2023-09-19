import 'package:cropi/src/widgets/templates/simple_layout.dart';
import 'package:flutter/material.dart';
import 'package:cropi/src/features/register/bloc/bloc.dart';
import 'package:cropi/src/features/register/widgets/register_body.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: const Scaffold(
        body: RegisterView(),
      ),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleLayout(title: 'Nova conta', body: RegisterBody());
  }
}
