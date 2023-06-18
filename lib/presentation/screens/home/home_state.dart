part of 'home_cubit.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class HomeFillDataState extends HomeState {
  // final String? userName;
  // final String? photoURL;
  final UserEntity user;

  // HomeFillDataState({required this.userName, required this.photoURL});
  HomeFillDataState({required this.user});

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class HomeGetImageState extends HomeState {
  final String? photoURL;

  HomeGetImageState({
    required this.photoURL,
  });

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class HomeGetUserNameState extends HomeState {
  final String? displayName;

  HomeGetUserNameState({
    required this.displayName,
  });

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class HomeGetWorkoutsState extends HomeState {
  final List<WorkoutData> workouts;

  HomeGetWorkoutsState({
    required this.workouts,
  });

  @override
  List<Object?> get props => [identityHashCode(this)];
}
