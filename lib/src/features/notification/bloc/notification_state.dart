part of 'notification_bloc.dart';

/// {@template notification_state}
/// NotificationState description
/// {@endtemplate}
class NotificationState extends Equatable {
  const NotificationState({
    this.notifications = const [],
  });

  final List<dynamic> notifications;

  @override
  List<Object> get props => [notifications];

  /// Creates a copy of the current NotificationState with property changes
  NotificationState copyWith({
    List<dynamic>? notifications,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
    );
  }
}

class NotificationInitial extends NotificationState {
  const NotificationInitial() : super();
}

class NotificationLoading extends NotificationState {
  const NotificationLoading() : super();
}

class NotificationLoaded extends NotificationState {
  const NotificationLoaded({
    required List<dynamic> notifications,
  }) : super(notifications: notifications);
}
