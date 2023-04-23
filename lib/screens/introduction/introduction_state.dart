part of 'introduction_cubit.dart';

@immutable
abstract class IntroductionState extends Equatable {}

class IntroductionInitial extends IntroductionState {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class IntroductionScreenChangedState extends IntroductionState {
  final int? counter;

  IntroductionScreenChangedState({
    this.counter,
  });

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class IntroductionLoadIntroState extends IntroductionState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class IntroductionNextScreenState extends IntroductionState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
