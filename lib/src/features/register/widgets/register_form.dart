import 'package:cropi/src/features/register/bloc/bloc.dart';
import 'package:cropi/src/widgets/atom/primary_button.dart';
import 'package:cropi/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    this.name = '',
    this.email = '',
    this.bornDate = '',
    this.password = '',
    this.confirmPassword = '',
    super.key,
  });

  final String name;
  final String email;
  final String bornDate;
  final String password;
  final String confirmPassword;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController(text: '');
  final _emailController = TextEditingController(text: '');
  final _dateTimeController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _confirmPasswordController = TextEditingController(text: '');

  bool _hidePassword = false;
  bool _hidePasswordConfirm = false;
  bool _isLoading = false;

  @override
  void initState() {
    _nameController.text = widget.name;
    _emailController.text = widget.email;
    _dateTimeController.text = widget.bornDate;
    _passwordController.text = widget.password;
    _confirmPasswordController.text = widget.confirmPassword;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 15),
                Input(
                  label: 'Nome',
                  controller: _nameController,
                  onChanged: (value) {
                    context.read<RegisterBloc>().add(
                          RegisterNameChanged(value),
                        );
                  },
                  validate: (value) {
                    if (value == null || value == '') {
                      return 'Campo obrigatório';
                    }
                  },
                ),
                const SizedBox(height: 15),
                Input(
                  label: 'Email',
                  controller: _emailController,
                  type: TextInputType.emailAddress,
                  error:
                      context.read<RegisterBloc>().state is RegisterErrorState
                          ? (context.read<RegisterBloc>().state
                                  as RegisterErrorState)
                              .errorEmail
                          : null,
                  onChanged: (value) {
                    context.read<RegisterBloc>().add(
                          RegisterEmailChanged(value),
                        );
                  },
                  validate: (value) {
                    if (value == null || value == '') {
                      return 'Campo obrigatório';
                    }

                    RegExp emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                    if (!emailRegex.hasMatch(value)) {
                      return 'Email inválido';
                    }
                  },
                ),
                const SizedBox(height: 15),
                Input(
                  label: 'Data de nascimento',
                  type: TextInputType.datetime,
                  controller: _dateTimeController,
                  readOnly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate:
                          DateTime.now().subtract(const Duration(days: 365)),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (date != null) {
                      _dateTimeController.text =
                          DateFormat('dd/MM/yyyy').format(date);
                      // ignore: use_build_context_synchronously
                      context.read<RegisterBloc>().add(
                            RegisterBornDateChanged(date),
                          );
                    }
                  },
                  validate: (value) {
                    if (value == null || value == '') {
                      return 'Campo obrigatório';
                    }
                  },
                ),
                const SizedBox(height: 15),
                Input(
                  label: 'Senha',
                  controller: _passwordController,
                  obscureText: !_hidePassword,
                  onChanged: (value) {
                    context.read<RegisterBloc>().add(
                          RegisterPasswordChanged(value),
                        );
                  },
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      icon: Icon(_hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
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

                    if (value.length < 6) {
                      return 'A senha deve ter no mínimo 6 caracteres';
                    }
                  },
                ),
                const SizedBox(height: 15),
                Input(
                  label: 'Confirmar senha',
                  controller: _confirmPasswordController,
                  obscureText: !_hidePasswordConfirm,
                  onChanged: (value) {
                    context.read<RegisterBloc>().add(
                          RegisterConfirmPasswordChanged(value),
                        );
                  },
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      icon: Icon(_hidePasswordConfirm
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _hidePasswordConfirm = !_hidePasswordConfirm;
                        });
                      },
                    ),
                  ),
                  validate: (value) {
                    if (value == null || value == '') {
                      return 'Campo obrigatório';
                    }

                    if (value != context.read<RegisterBloc>().state.password) {
                      return 'As senhas não coincidem';
                    }
                  },
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          PrimaryButton(
            text: 'Criar conta',
            isLoading: _isLoading,
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }

              setState(() {
                _isLoading = true;
              });

              context.read<RegisterBloc>().add(
                RegisterSubmit(onEnd: () {
                  setState(() {
                    _isLoading = false;
                  });

                  if (context.read<RegisterBloc>().state
                      is RegisterSuccessState) {
                    context.go('/register/success');
                    return const SizedBox();
                  }
                }),
              );
            },
          )
        ],
      ),
    );
  }
}
