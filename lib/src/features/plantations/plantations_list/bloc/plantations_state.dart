part of 'plantations_bloc.dart';

class PlantationsState extends Equatable {
  const PlantationsState({
    this.plantations = const [],
  });

  final List<Plantation> plantations;

  @override
  List<Object> get props => [plantations];

  PlantationsState copyWith({
    List<Plantation>? plantations,
  }) {
    return PlantationsState(
      plantations: plantations ?? this.plantations,
    );
  }
}

class PlantationsInitial extends PlantationsState {
  const PlantationsInitial() : super();
}

class PlantationsLoaded extends PlantationsState {
  const PlantationsLoaded({
    required List<Plantation> plantations,
  }) : super(plantations: plantations);
}

class PlantationsLoadingError extends PlantationsState {
  const PlantationsLoadingError({
    required String message,
  }) : super();
}
