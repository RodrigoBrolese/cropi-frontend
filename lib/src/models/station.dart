import 'package:equatable/equatable.dart';

class Station extends Equatable {
  const Station({
    required this.id,
    required this.inmetCode,
    required this.city,
    required this.uf,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.createDate,
    required this.updateDate,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        id: json['id'] as int,
        inmetCode: json['inmet_code'] as String,
        city: json['city'] as String,
        uf: json['uf'] as String,
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
        status: json['status'] as bool,
        createDate: json['create_date'] as String,
        updateDate: json['update_date'] as String?,
      );

  final int id;
  final String inmetCode;
  final String city;
  final String uf;
  final double latitude;
  final double longitude;
  final bool status;
  final String createDate;
  final String? updateDate;

  Station copyWith({
    int? id,
    String? inmetCode,
    String? city,
    String? uf,
    double? latitude,
    double? longitude,
    bool? status,
    String? createDate,
    String? updateDate,
  }) {
    return Station(
      id: id ?? this.id,
      inmetCode: inmetCode ?? this.inmetCode,
      city: city ?? this.city,
      uf: uf ?? this.uf,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      status: status ?? this.status,
      createDate: createDate ?? this.createDate,
      updateDate: updateDate ?? this.updateDate,
    );
  }

  @override
  List<Object> get props => [
        id,
        inmetCode,
        city,
        uf,
        latitude,
        longitude,
        status,
        createDate,
        updateDate!,
      ];

  @override
  String toString() =>
      'User { id: $id, inmetCode: $inmetCode, city: $city, uf: $uf, latitude: $latitude, longitude: $longitude, status: $status, createDate: $createDate, updateDate: $updateDate }';
}
