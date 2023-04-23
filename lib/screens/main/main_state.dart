part of 'main_cubit.dart';

@immutable
abstract class MainState extends Equatable {}

class MainInitial extends MainState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class MainItemSelectedState extends MainState {
  final int index;

  MainItemSelectedState({
    required this.index,
  });

  @override
  List<Object?> get props => [identityHashCode(index)];
}
