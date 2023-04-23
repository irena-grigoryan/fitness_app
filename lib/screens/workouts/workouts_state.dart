part of 'workouts_cubit.dart';

@immutable
abstract class WorkoutsState extends Equatable {}

class WorkoutsInitialState extends WorkoutsState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
