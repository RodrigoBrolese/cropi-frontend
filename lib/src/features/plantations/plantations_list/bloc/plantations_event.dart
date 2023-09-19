part of 'plantations_bloc.dart';

abstract class PlantationsEvent extends Equatable {
  const PlantationsEvent();

  @override
  List<Object> get props => [];
}

class LoadPlantationsEvent extends PlantationsEvent {
  const LoadPlantationsEvent();
}

class CreatePlantationEvent extends PlantationsEvent {
  const CreatePlantationEvent();
}
