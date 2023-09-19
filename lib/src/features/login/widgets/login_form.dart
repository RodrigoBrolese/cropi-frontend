import 'package:cropi/src/app/bloc/bloc.dart';
import 'package:cropi/src/features/login/login.dart';
import 'package:cropi/src/widgets/atom/primary_button.dart';
import 'package:cropi/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  bool _hidePassword = false;
  bool _isLoading = false;

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Input(
            label: 'Email',
            prefixIcon: const Icon(Icons.person),
            type: TextInputType.emailAddress,
            controller: emailController,
            validate: (value) {
              if (value == null || value == '') {
                return 'Campo obrigatório';
              }

              RegExp emailRegex =
                  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

              if (!emailRegex.hasMatch(value)) {
                return 'Email inválido';
              }
            },
          ),
          const SizedBox(height: 30),
          Input(
            label: 'Senha',
            controller: passwordController,
            obscureText: !_hidePassword,
            autocorrect: _hidePassword,
            prefixIcon: const Icon(Icons.key),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(
                    _hidePassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
              ),
            ),
            validate: (value) {
              if (value == null || value == '') {
                return 'Campo obrigatório';
              }
            },
          ),
          const SizedBox(height: 30),
          PrimaryButton(
            text: 'Entrar',
            isLoading: _isLoading,
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }

              setState(() {
                _isLoading = true;
              });

              BlocProvider.of<LoginBloc>(context).add(
                LoginUserEvent(
                    email: emailController.text,
                    password: passwordController.text,
                    onEnd: (result) {
                      if (result == null) {
                        emailController.clear();
                        passwordController.clear();
                      }

                      setState(() {
                        _isLoading = false;
                      });

                      if (result != null) {
                        context
                            .read<AppBloc>()
                            .add(AuthenticateAppEvent(user: result));
                        context.goNamed('home');
                      }
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
