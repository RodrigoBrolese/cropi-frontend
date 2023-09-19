import 'package:cropi/src/features/register/register.dart';
import 'package:cropi/src/widgets/atom/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterSuccessBody extends StatelessWidget {
  const RegisterSuccessBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 10),
            Text("Sua conta foi criada com sucesso!",
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 50),
            PrimaryButton(
              onPressed: () {
                context.go('/');
              },
              text: 'Faça o login',
            ),
          ],
        );
      },
    );
  }
}
