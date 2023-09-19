part of 'plantations_create_bloc.dart';

class PlantationsCreateState extends Equatable {
  const PlantationsCreateState({
    this.cultures,
    this.userPosition,
    this.name,
    this.area,
    this.plantingDate,
    this.location,
    this.cultureSelected,
    this.error,
  }) : super();

  final List<Culture>? cultures;
  final Position? userPosition;
  final String? name;
  final String? area;
  final DateTime? plantingDate;
  final LatLng? location;
  final Culture? cultureSelected;
  final String? error;

  @override
  List<Object> get props => [
        cultures ?? [],
        userPosition ?? [],
        location ?? [],
        name ?? '',
        area ?? '',
        plantingDate ?? [],
        cultureSelected ?? [],
        error ?? '',
      ];

  PlantationsCreateState copyWith({
    List<Culture>? cultures,
    Position? userPosition,
    String? name,
    LatLng? location,
    String? area,
    DateTime? plantingDate,
    Culture? cultureSelected,
    String? error,
  }) {
    return PlantationsCreateState(
      cultures: cultures ?? this.cultures,
      userPosition: userPosition ?? this.userPosition,
      location: location ?? this.location,
      name: name ?? this.name,
      area: area ?? this.area,
      plantingDate: plantingDate ?? this.plantingDate,
      cultureSelected: cultureSelected ?? this.cultureSelected,
      error: error ?? this.error,
    );
  }
}

class PlantationsCreateLoading extends PlantationsCreateState {
  const PlantationsCreateLoading() : super();
}

class PlantationsCreateLoaded extends PlantationsCreateState {
  const PlantationsCreateLoaded({
    required List<Culture> cultures,
    required Position? userPosition,
  }) : super(cultures: cultures, userPosition: userPosition);
}

class PlantationsCreateError extends PlantationsCreateState {
  const PlantationsCreateError() : super();
}

class PlantationsCreateSuccess extends PlantationsCreateState {
  const PlantationsCreateSuccess({required this.id}) : super();

  final String id;
}
