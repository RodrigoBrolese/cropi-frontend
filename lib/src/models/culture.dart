import 'package:equatable/equatable.dart';

class Culture extends Equatable {
  const Culture({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.description,
    required this.createDate,
  });

  factory Culture.fromJson(Map<String, dynamic> json) => Culture(
        id: json['id'] as int,
        name: json['name'] as String,
        scientificName: json['scientific_name'] as String,
        description: json['description'] as String,
        createDate: json['create_date'] as String,
      );

  final int id;
  final String name;
  final String scientificName;
  final String description;
  final String createDate;

  Culture copyWith({
    int? id,
    String? name,
    String? scientificName,
    String? description,
    String? createDate,
  }) {
    return Culture(
      id: id ?? this.id,
      name: name ?? this.name,
      scientificName: scientificName ?? this.scientificName,
      description: description ?? this.description,
      createDate: createDate ?? this.createDate,
    );
  }

  @override
  List<Object> get props => [id, name, scientificName, description, createDate];
}
