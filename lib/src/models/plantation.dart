import 'package:cropi/src/models/culture.dart';
import 'package:cropi/src/models/station.dart';
import 'package:equatable/equatable.dart';

class Plantation extends Equatable {
  const Plantation({
    required this.id,
    required this.alias,
    required this.area,
    required this.createDate,
    required this.updateDate,
    required this.culture,
    required this.station,
    required this.latitude,
    required this.longitude,
    required this.hasOcurrences,
    required this.plantingDate,
  });

  factory Plantation.fromJson(Map<String, dynamic> json) => Plantation(
        id: json['id'] as String,
        alias: json['alias'] as String,
        area: json['area'] as double,
        createDate: json['create_date'] as String,
        updateDate: json['update_date'] as String?,
        culture: Culture.fromJson(json['culture'] as Map<String, dynamic>),
        station: Station.fromJson(json['station'] as Map<String, dynamic>),
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
        hasOcurrences: json['has_ocurrences'] as bool,
        plantingDate: json['planting_date'] as String,
      );

  final String id;
  final String alias;
  final double area;
  final String createDate;
  final String? updateDate;
  final Culture culture;
  final Station station;
  final double latitude;
  final double longitude;
  final bool hasOcurrences;
  final String plantingDate;

  Plantation copyWith({
    String? id,
    String? alias,
    double? area,
    String? createDate,
    String? updateDate,
    Culture? culture,
    Station? station,
    double? latitude,
    double? longitude,
    bool? hasOcurrences,
    String? plantingDate,
  }) {
    return Plantation(
      id: id ?? this.id,
      alias: alias ?? this.alias,
      area: area ?? this.area,
      createDate: createDate ?? this.createDate,
      updateDate: updateDate ?? this.updateDate,
      culture: culture ?? this.culture,
      station: station ?? this.station,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      hasOcurrences: hasOcurrences ?? this.hasOcurrences,
      plantingDate: plantingDate ?? this.plantingDate,
    );
  }

  @override
  List<Object> get props => [
        id,
        alias,
        area,
        createDate,
        updateDate!,
        culture,
        station,
        latitude,
        longitude,
        hasOcurrences,
        plantingDate,
      ];

  @override
  String toString() {
    return 'Plantation(id: $id, alias: $alias, area: $area, createDate: $createDate, updateDate: $updateDate, culture: $culture, station: $station, latitude: $latitude, longitude: $longitude, hasOcurrences: $hasOcurrences, plantingDate: $plantingDate)';
  }
}
