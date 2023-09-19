import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cropi/src/services/api/api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterInitial()) {
    on<RegisterNameChanged>(_onNameChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterBornDateChanged>(_onBornDateChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterSubmit>(_onSubmit);
  }

  void _onNameChanged(RegisterNameChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onEmailChanged(
      RegisterEmailChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onBornDateChanged(
      RegisterBornDateChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(bornDate: event.bornDate));
  }

  void _onPasswordChanged(
      RegisterPasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onConfirmPasswordChanged(
      RegisterConfirmPasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  FutureOr<void> _onSubmit(
    RegisterSubmit event,
    Emitter<RegisterState> emit,
  ) async {
    ApiClient apiClient = GetIt.I<ApiClient>();

    await apiClient.post('/user/register', body: {
      'name': state.name,
      'email': state.email,
      'born_date': DateFormat('yyyy-MM-dd').format(state.bornDate!),
      'password': state.password,
    }).then((response) {
      if (response.statusCode != 201) {
        List<dynamic> errors = jsonDecode(response.body)['errors'] ?? [];

        String? errorEmail = errors.firstWhere(
              (element) => element['field'] == 'email',
              orElse: () => null,
            )['message'] ??
            '';

        emit(RegisterErrorState(
          name: state.name,
          email: state.email,
          bornDate: state.bornDate,
          message: "Verifique os campos",
          errorEmail: errorEmail!,
        ));
        return;
      }

      emit(const RegisterSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }

      emit(RegisterErrorState(
        message: "Ocorreu um erro desconhecido",
        name: state.name,
        email: state.email,
        bornDate: state.bornDate,
      ));
    });

    event.onEnd();
  }
}
