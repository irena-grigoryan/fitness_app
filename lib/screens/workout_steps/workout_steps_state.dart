part of 'workout_steps_cubit.dart';

@immutable
abstract class WorkoutStepsState extends Equatable {}

class WorkoutStepsInitialState extends WorkoutStepsState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
