import 'package:equatable/equatable.dart';

class Pathogenic extends Equatable {
  const Pathogenic({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.description,
    required this.createDate,
  });

  /// Creates a Pathogenic from Json map
  factory Pathogenic.fromJson(Map<String, dynamic> json) => Pathogenic(
        id: json['id'] as int,
        name: json['name'] as String,
        scientificName: json['scientific_name'] as String,
        description: json['description'] as String,
        createDate: json['create_date'] as String,
      );

  /// A description for id
  final int id;

  /// A description for name
  final String name;

  /// A description for scientific_name
  final String scientificName;

  /// A description for description
  final String description;

  /// A description for create_date
  final String createDate;

  /// Creates a copy of the current Pathogenic with property changes
  Pathogenic copyWith({
    int? id,
    String? name,
    String? scientificName,
    String? description,
    String? createDate,
  }) {
    return Pathogenic(
      id: id ?? this.id,
      name: name ?? this.name,
      scientificName: scientificName ?? this.scientificName,
      description: description ?? this.description,
      createDate: createDate ?? this.createDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        scientificName,
        description,
        createDate,
      ];

  /// Creates a Json map from a Pathogenic
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'scientific_name': scientificName,
        'description': description,
        'create_date': createDate,
      };

  /// Creates a toString() override for Pathogenic
  @override
  String toString() =>
      'Pathogenic(id: $id, name: $name, scientific_name: $scientificName, description: $description, create_date: $createDate)';
}
