part of 'workouts_cubit.dart';

@immutable
abstract class WorkoutsState extends Equatable {}

class WorkoutsInitialState extends WorkoutsState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class WorkoutsOnSelectState extends WorkoutsState {
  final WorkoutData workout;

  WorkoutsOnSelectState({required this.workout});

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class WorkoutsReloadState extends WorkoutsState {
  final List<WorkoutData> workouts;

  WorkoutsReloadState({
    required this.workouts,
  });

  @override
  List<Object?> get props => [identityHashCode(this)];
}
