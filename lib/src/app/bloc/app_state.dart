part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    this.user,
  });

  final User? user;

  @override
  List<Object> get props => [user!];

  AppState copyWith({
    User? user,
  }) {
    return AppState(
      user: user ?? this.user,
    );
  }
}

class AppInitial extends AppState {
  const AppInitial() : super();
}
