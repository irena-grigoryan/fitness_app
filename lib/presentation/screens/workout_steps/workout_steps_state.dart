part of 'workout_steps_cubit.dart';

@immutable
abstract class WorkoutStepsState extends Equatable {}

class WorkoutStepsInitialState extends WorkoutStepsState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class WorkoutItemTappedState extends WorkoutStepsState {
  final WorkoutData workout;
  final int index;

  WorkoutItemTappedState({
    required this.workout,
    required this.index,
  });

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class WorkoutStepsReloadState extends WorkoutStepsState {
  final WorkoutData workout;

  WorkoutStepsReloadState({
    required this.workout,
  });

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class WorkoutStepsStartState extends WorkoutStepsState {
  final WorkoutData? workout;
  final int? index;
  final bool? isReplace;

  WorkoutStepsStartState({
    this.workout,
    this.index,
    this.isReplace,
  });

  @override
  List<Object?> get props => [identityHashCode(this)];
}
