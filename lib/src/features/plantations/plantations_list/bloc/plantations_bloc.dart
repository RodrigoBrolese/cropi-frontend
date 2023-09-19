import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cropi/src/models/plantation.dart';
import 'package:cropi/src/services/api/api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
part 'plantations_event.dart';
part 'plantations_state.dart';

class PlantationsBloc extends Bloc<PlantationsEvent, PlantationsState> {
  PlantationsBloc() : super(const PlantationsInitial()) {
    on<LoadPlantationsEvent>(_onLoadPlantationsEvent);
  }

  FutureOr<void> _onLoadPlantationsEvent(
    LoadPlantationsEvent event,
    Emitter<PlantationsState> emit,
  ) async {
    final ApiClient apiClient = GetIt.I<ApiClient>();

    try {
      var response = await apiClient.get('/plantations');

      if (response.statusCode == 200) {
        final List<dynamic> data =
            apiClient.bodyToJson(response)['plantations'];

        final List<Plantation> plantations =
            data.map((e) => Plantation.fromJson(e)).toList();

        emit(PlantationsLoaded(plantations: plantations));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(PlantationsLoadingError(message: e.toString()));
    }
  }
}
