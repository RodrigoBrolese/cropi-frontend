part of 'plantations_show_bloc.dart';

class PlantationsShowState extends Equatable {
  const PlantationsShowState({
    this.plantation,
    this.plantationOcurrences,
    this.regionOcurrences,
    this.pathogenics,
  });

  final Plantation? plantation;
  final List<Ocurrence>? plantationOcurrences;
  final List<Ocurrence>? regionOcurrences;
  final List<Pathogenic>? pathogenics;

  @override
  List<Object> get props => [
        plantation ?? [],
        plantationOcurrences ?? [],
        regionOcurrences ?? [],
        pathogenics ?? [],
      ];

  PlantationsShowState copyWith({
    Plantation? plantation,
    Station? station,
    List<Ocurrence>? plantationOcurrences,
    List<Ocurrence>? regionOcurrences,
    List<Pathogenic>? pathogenics,
  }) {
    return PlantationsShowState(
      plantation: plantation ?? this.plantation,
      plantationOcurrences: plantationOcurrences ?? this.plantationOcurrences,
      regionOcurrences: regionOcurrences ?? this.regionOcurrences,
      pathogenics: pathogenics ?? this.pathogenics,
    );
  }
}

class PlantationsShowInitial extends PlantationsShowState {
  const PlantationsShowInitial() : super();
}

class PlantationsShowError extends PlantationsShowState {
  const PlantationsShowError() : super();
}

class PlantationsShowLoaded extends PlantationsShowState {
  const PlantationsShowLoaded({
    required super.plantation,
    required super.plantationOcurrences,
    required super.regionOcurrences,
    required super.pathogenics,
  }) : super();
}
