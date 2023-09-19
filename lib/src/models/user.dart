import 'package:equatable/equatable.dart';

/// {@template user}
/// User description
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.authToken,
    required this.rememberToken,
    required this.bornDate,
    this.hasUnviewedNotifications = false,
  });

  /// Creates a User from Json map
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        authToken: json['authToken'] as String,
        rememberToken: json['rememberToken'] as String,
        bornDate: json['bornDate'] as String,
        hasUnviewedNotifications: json['hasUnviewedNotifications'] as bool,
      );

  /// A description for id
  final String id;

  /// A description for name
  final String name;

  /// A description for email
  final String email;

  /// A description for authToken
  final String authToken;

  /// A description for rememberToken
  final String rememberToken;

  /// A description for born_date
  final String bornDate;

  /// A description for hasUnviewedNotifications
  final bool hasUnviewedNotifications;

  /// Creates a copy of the current User with property changes
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? authToken,
    String? rememberToken,
    String? bornDate,
    bool? hasUnviewedNotifications,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      authToken: authToken ?? this.authToken,
      rememberToken: rememberToken ?? this.rememberToken,
      bornDate: bornDate ?? this.bornDate,
      hasUnviewedNotifications:
          hasUnviewedNotifications ?? this.hasUnviewedNotifications,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        authToken,
        rememberToken,
        bornDate,
        hasUnviewedNotifications,
      ];

  /// Creates a Json map from a User
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'email': email,
        'authToken': authToken,
        'rememberToken': rememberToken,
        'born_date': bornDate,
        'hasUnviewedNotifications': hasUnviewedNotifications,
      };

  /// Creates a toString() override for User
  @override
  String toString() =>
      'User(name: $name, authToken: $authToken, rememberToken: $rememberToken, id: $id, email: $email, born_date: $bornDate, hasUnviewedNotifications: $hasUnviewedNotifications)';
}
