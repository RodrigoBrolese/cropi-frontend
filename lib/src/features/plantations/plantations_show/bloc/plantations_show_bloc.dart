import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cropi/src/models/models.dart';
import 'package:cropi/src/services/api/api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http_parser/http_parser.dart';
part 'plantations_show_event.dart';
part 'plantations_show_state.dart';

class PlantationsShowBloc
    extends Bloc<PlantationsShowEvent, PlantationsShowState> {
  PlantationsShowBloc() : super(const PlantationsShowInitial()) {
    on<LoadPlantationShowEvent>(_onLoadPlantationShowEventEvent);
    on<AddPlantationOcurrenceEvent>(_onAddPlantationOcurrenceEventEvent);
  }

  FutureOr<void> _onLoadPlantationShowEventEvent(
    LoadPlantationShowEvent event,
    Emitter<PlantationsShowState> emit,
  ) async {
    ApiClient apiClient = GetIt.I<ApiClient>();

    try {
      var response = await apiClient.get("/plantations/${event.plantationId}");

      if (response.statusCode != 200) {
        throw Exception("Erro ao carregar dados");
      }

      var responseJson = apiClient.bodyToJson(response);

      Plantation plantation = Plantation.fromJson({
        "id": responseJson['id'],
        "alias": responseJson['alias'],
        "area": responseJson['area'],
        "create_date": responseJson['create_date'],
        "update_date": responseJson['update_date'],
        "culture": responseJson['culture'],
        "station": responseJson['station'],
        "latitude": responseJson['latitude'],
        "longitude": responseJson['longitude'],
        "has_ocurrences": responseJson['has_ocurrences'],
        "planting_date": responseJson['planting_date'],
      });

      List<Ocurrence> plantationOcurrences = [];
      List<Ocurrence> regionOcurrences = [];

      if (responseJson["plantation_ocurrences"] != null) {
        for (var ocurrences in responseJson["plantation_ocurrences"]) {
          plantationOcurrences.add(Ocurrence.fromJson(ocurrences));
        }
      }

      if (responseJson["region_ocurrences"] != null) {
        for (var ocurrences in responseJson["region_ocurrences"]) {
          regionOcurrences.add(Ocurrence.fromJson(ocurrences));
        }
      }

      emit(PlantationsShowLoaded(
        plantation: plantation,
        plantationOcurrences: plantationOcurrences,
        regionOcurrences: regionOcurrences,
        pathogenics: const [
          Pathogenic(
              id: 1,
              name: 'Verrugose',
              scientificName: '',
              description: '',
              createDate: '2021-10-10'),
        ],
      ));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      emit(const PlantationsShowError());
    }
  }

  FutureOr<void> _onAddPlantationOcurrenceEventEvent(
      AddPlantationOcurrenceEvent event,
      Emitter<PlantationsShowState> emit) async {
    ApiClient apiClient = GetIt.I<ApiClient>();

    try {
      var response = await apiClient.post(
        "/plantations/${state.plantation?.id}/ocurrences",
        body: {
          "pathogenic_id": event.ocurrence.pathogenic.id,
          "occurrence_date": event.ocurrence.occurrenceDate,
        },
      );

      if (response.statusCode != 200) {
        throw Exception("Erro ao carregar dados");
      }

      var responseJson = apiClient.bodyToJson(response);

      Ocurrence ocurrence = event.ocurrence.copyWith(
        id: responseJson['ocurrence']['id'],
        createDate: responseJson['ocurrence']['create_date'],
        updateDate: responseJson['ocurrence']['update_date'],
      );

      if (ocurrence.image != null) {
        var responseImage = await apiClient.postFile(
          "/plantations/${state.plantation?.id}/ocurrences/${ocurrence.id}/image",
          path: ocurrence.image!,
          fileName: "image",
          mediaType: MediaType("image", "jpeg"),
        );

        ocurrence = ocurrence.copyWith(
          image: apiClient.bodyToJson(responseImage)['image'],
        );
      }

      emit(state.copyWith(
        plantationOcurrences: [ocurrence, ...state.plantationOcurrences!],
      ));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      emit(const PlantationsShowError());
    }
  }
}
