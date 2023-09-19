import 'package:cropi/src/features/register/register.dart';
import 'package:cropi/src/widgets/atom/alert_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Column(
          children: [
            state is RegisterErrorState
                ? AlertCard(
                    message: state.message,
                    color: Colors.red.withOpacity(.7),
                    textColor: Colors.white,
                    margin: const EdgeInsets.only(bottom: 15),
                  )
                : const SizedBox(),
            Expanded(
                child: RegisterForm(
              name: state.name,
              email: state.email,
              bornDate: state.bornDate != null
                  ? DateFormat('dd/MM/yyyy').format(state.bornDate!)
                  : '',
              password: state.password,
              confirmPassword: state.confirmPassword,
            )),
            Center(
              child: TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('Cancelar'),
              ),
            ),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }
}
