import 'package:cropi/src/features/login/widgets/widgets.dart';
import 'package:cropi/src/widgets/atom/alert_card.dart';
import 'package:cropi/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cropi/src/features/login/bloc/bloc.dart';
import 'package:go_router/go_router.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginInitial) {
          context.read<LoginBloc>().add(LoginCheckEvent(context));
          return const SplashScreen();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Cropi',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.right,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 40),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 46),
                textAlign: TextAlign.right,
              ),
            ),
            state is LoginErrorState
                ? AlertCard(
                    message: state.message,
                    color: Colors.red.withOpacity(.7),
                    textColor: Colors.white,
                    margin: const EdgeInsets.only(bottom: 15),
                  )
                : const SizedBox(),
            Expanded(
                child: ListView(
              children: [
                const SizedBox(
                  height: 5,
                ),
                const LoginForm(),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      context.push('/register');
                    },
                    child: const Text('Criar Conta'),
                  ),
                )
              ],
            ))
          ],
        );
      },
    );
  }
}
