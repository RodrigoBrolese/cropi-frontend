import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cropi/src/models/culture.dart';
import 'package:cropi/src/services/api/api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

part 'plantations_create_event.dart';
part 'plantations_create_state.dart';

class PlantationsCreateBloc
    extends Bloc<PlantationsCreateEvent, PlantationsCreateState> {
  PlantationsCreateBloc() : super(const PlantationsCreateLoading()) {
    on<LoadPlantationCreateEvent>(_onCustomPlantationsCreateEvent);
    on<PlantationsCreateLocationSelected>(_onPlantationsCreateLocationSelected);
    on<PlantationsCreateSave>(_onPlantationsCreateSave);
    on<PlantationsCreateNameChanged>(_onPlantationsCreateNameChanged);
    on<PlantationsCreateAreaChanged>(_onPlantationsCreateAreaChanged);
    on<PlantationsCreatePlantingDateChanged>(
        _onPlantationsCreatePlantingDateChanged);
    on<PlantationsCreateCultureChanged>(_onPlantationsCreateCultureChanged);
  }

  FutureOr<void> _onCustomPlantationsCreateEvent(
    LoadPlantationCreateEvent event,
    Emitter<PlantationsCreateState> emit,
  ) async {
    Position? position;

    if (await Geolocator.isLocationServiceEnabled()) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse ||
          permission == LocationPermission.unableToDetermine) {
        try {
          position = await Geolocator.getCurrentPosition();
        } catch (e) {
          if (kDebugMode) print(e);
        }
      }
    }

    if (position == null) {
      var response = await http.get(Uri.parse('https://ipapi.co/json'));

      if (response.statusCode == 200) {
        var json = GetIt.I<ApiClient>().bodyToJson(response);

        position = Position(
          latitude: json['latitude'] as double,
          longitude: json['longitude'] as double,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
      }
    }

    if (position == null) {
      emit(
        PlantationsCreateLoaded(
            userPosition: Position(
                latitude: -28.481460,
                longitude: -49.005001,
                timestamp: DateTime.now(),
                accuracy: 0,
                altitude: 0,
                altitudeAccuracy: 0,
                heading: 0,
                headingAccuracy: 0,
                speed: 0,
                speedAccuracy: 0),
            cultures: const [
              Culture(
                  id: 1,
                  name: 'Maracujá',
                  scientificName: '',
                  description: '',
                  createDate: '')
            ]),
      );
      return;
    }

    emit(
      PlantationsCreateLoaded(userPosition: position, cultures: const [
        Culture(
            id: 1,
            name: 'Maracujá',
            scientificName: '',
            description: '',
            createDate: '')
      ]),
    );
  }

  FutureOr<void> _onPlantationsCreateLocationSelected(
      PlantationsCreateLocationSelected event,
      Emitter<PlantationsCreateState> emit) {
    emit(state.copyWith(location: null));

    emit(state.copyWith(location: event.location));
  }

  Future<void> _onPlantationsCreateSave(
      PlantationsCreateSave event, Emitter<PlantationsCreateState> emit) async {
    if (state.location == null) {
      emit(state.copyWith(error: "Selecione uma localização"));
      event.onEnd(false);
      return;
    }

    ApiClient apiClient = GetIt.I<ApiClient>();

    try {
      Response response = await apiClient.post('/plantations', body: {
        'alias': state.name,
        'area': int.parse(state.area!),
        'planting_date': DateFormat('yyyy-MM-dd').format(state.plantingDate!),
        'culture_id': state.cultureSelected?.id,
        'latitude': state.location?.latitude,
        'longitude': state.location?.longitude,
      });

      if (response.statusCode != 201) {
        throw Exception("Ocorreu um erro ao cadastrar a plantação");
      }

      emit(PlantationsCreateSuccess(
          id: apiClient.bodyToJson(response)['plantation']));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      event.onEnd(false);

      emit(state.copyWith(error: "Ocorreu um erro ao cadastrar a plantação"));
      return;
    }

    event.onEnd(true);
  }

  FutureOr<void> _onPlantationsCreateNameChanged(
      PlantationsCreateNameChanged event,
      Emitter<PlantationsCreateState> emit) {
    emit(state.copyWith(name: event.name));
  }

  FutureOr<void> _onPlantationsCreateAreaChanged(
      PlantationsCreateAreaChanged event,
      Emitter<PlantationsCreateState> emit) {
    emit(state.copyWith(area: event.area));
  }

  FutureOr<void> _onPlantationsCreatePlantingDateChanged(
      PlantationsCreatePlantingDateChanged event,
      Emitter<PlantationsCreateState> emit) {
    emit(state.copyWith(plantingDate: event.plantingDate));
  }

  FutureOr<void> _onPlantationsCreateCultureChanged(
      PlantationsCreateCultureChanged event,
      Emitter<PlantationsCreateState> emit) {
    emit(state.copyWith(cultureSelected: event.culture));
  }
}
