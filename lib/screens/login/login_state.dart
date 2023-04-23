part of 'login_cubit.dart';

@immutable
abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LoginButtonEnableChangedState extends LoginState {
  final bool isEnabled;

  LoginButtonEnableChangedState({
    required this.isEnabled,
  });

  @override
  List<Object?> get props => [identityHashCode(isEnabled)];
}

class LoginShowErrorState extends LoginState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LoginNextResetPasswordScreenState extends LoginState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LoginNextRegistrationScreenState extends LoginState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LoginNextMainScreenState extends LoginState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
