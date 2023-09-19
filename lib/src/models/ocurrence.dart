import 'package:cropi/src/models/pathogenic.dart';
import 'package:equatable/equatable.dart';

class Ocurrence extends Equatable {
  const Ocurrence({
    required this.id,
    required this.occurrenceDate,
    this.image,
    this.temperature,
    this.humidity,
    required this.createDate,
    required this.updateDate,
    required this.pathogenic,
  });

  /// Creates a Ocurrence from Json map
  factory Ocurrence.fromJson(Map<String, dynamic> json) => Ocurrence(
        id: json['id'] as String,
        occurrenceDate: json['occurrence_date'] as String,
        image: json['image'] as String?,
        temperature: json['temperature'] as double?,
        humidity: json['humidity'] as double?,
        createDate: json['create_date'] as String,
        updateDate: json['update_date'] as String,
        pathogenic:
            Pathogenic.fromJson(json['pathogenic'] as Map<String, dynamic>),
      );

  /// A description for id
  final String id;

  /// A description for occurrenceDate
  final String occurrenceDate;

  /// A description for image
  final String? image;

  /// A description for temperature
  final double? temperature;

  /// A description for humidity
  final double? humidity;

  /// A description for create_date
  final String createDate;

  /// A description for updateDate
  final String updateDate;

  /// A description for pathogenic
  final Pathogenic pathogenic;

  /// Creates a copy of the current Ocurrence with property changes
  Ocurrence copyWith({
    String? id,
    String? occurrenceDate,
    String? image,
    double? temperature,
    double? humidity,
    String? createDate,
    String? updateDate,
    Pathogenic? pathogenic,
  }) {
    return Ocurrence(
      id: id ?? this.id,
      occurrenceDate: occurrenceDate ?? this.occurrenceDate,
      image: image ?? this.image,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      createDate: createDate ?? this.createDate,
      updateDate: updateDate ?? this.updateDate,
      pathogenic: pathogenic ?? this.pathogenic,
    );
  }

  @override
  List<Object?> get props => [
        id,
        occurrenceDate,
        image,
        temperature,
        humidity,
        createDate,
        updateDate,
        pathogenic,
      ];

  /// Creates a Json map from a Ocurrence
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'occurrenceDate': occurrenceDate,
        'image': image,
        'temperature': temperature,
        'humidity': humidity,
        'createDate': createDate,
        'updateDate': updateDate,
        'pathogenic': pathogenic,
      };

  /// Creates a toString() override for Ocurrence
  @override
  String toString() =>
      'Ocurrence(id: $id, occurrenceDate: $occurrenceDate, image: $image, temperature: $temperature, humidity: $humidity, create_date: $createDate, updateDate: $updateDate, pathogenic: $pathogenic)';
}
