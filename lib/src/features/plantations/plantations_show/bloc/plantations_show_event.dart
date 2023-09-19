part of 'plantations_show_bloc.dart';

abstract class PlantationsShowEvent extends Equatable {
  const PlantationsShowEvent();

  @override
  List<Object> get props => [];
}

class LoadPlantationShowEvent extends PlantationsShowEvent {
  const LoadPlantationShowEvent({
    required this.plantationId,
  });

  final String plantationId;
}

class AddPlantationOcurrenceEvent extends PlantationsShowEvent {
  const AddPlantationOcurrenceEvent({
    required this.ocurrence,
  });

  final Ocurrence ocurrence;
}
