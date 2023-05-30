part of 'workout_start_cubit.dart';

@immutable
abstract class WorkoutStartState extends Equatable {}

class WorkoutStartInitialState extends WorkoutStartState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
