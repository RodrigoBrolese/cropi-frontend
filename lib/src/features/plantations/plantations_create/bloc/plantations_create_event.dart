part of 'plantations_create_bloc.dart';

abstract class PlantationsCreateEvent extends Equatable {
  const PlantationsCreateEvent();

  @override
  List<Object> get props => [];
}

class LoadPlantationCreateEvent extends PlantationsCreateEvent {
  const LoadPlantationCreateEvent();
}

class PlantationsCreateLocationSelected extends PlantationsCreateEvent {
  const PlantationsCreateLocationSelected({
    required this.location,
  });

  final LatLng location;

  @override
  List<Object> get props => [location];
}

class PlantationsCreateSave extends PlantationsCreateEvent {
  const PlantationsCreateSave({required this.onEnd});

  final Function onEnd;
}

class PlantationsCreateNameChanged extends PlantationsCreateEvent {
  const PlantationsCreateNameChanged({
    required this.name,
  });

  final String name;

  @override
  List<Object> get props => [name];
}

class PlantationsCreateAreaChanged extends PlantationsCreateEvent {
  const PlantationsCreateAreaChanged({
    required this.area,
  });

  final String area;

  @override
  List<Object> get props => [area];
}

class PlantationsCreatePlantingDateChanged extends PlantationsCreateEvent {
  const PlantationsCreatePlantingDateChanged({
    required this.plantingDate,
  });

  final DateTime plantingDate;

  @override
  List<Object> get props => [plantingDate];
}

class PlantationsCreateCultureChanged extends PlantationsCreateEvent {
  const PlantationsCreateCultureChanged({
    required this.culture,
  });

  final Culture culture;

  @override
  List<Object> get props => [culture];
}

class PlantationsCreateLocationChanged extends PlantationsCreateEvent {
  const PlantationsCreateLocationChanged({
    required this.location,
  });

  final LatLng location;

  @override
  List<Object> get props => [location];
}
