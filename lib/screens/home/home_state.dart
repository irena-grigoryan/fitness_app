part of 'home_cubit.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class HomeFillDataState extends HomeState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
