part of 'registration_cubit.dart';

@immutable
abstract class RegistrationState extends Equatable {}

class RegistrationInitial extends RegistrationState {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class RegistrationButtonEnableChangedState extends RegistrationState {
  final bool isEnabled;

  RegistrationButtonEnableChangedState({
    required this.isEnabled,
  });

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class RegistrationInvalidFieldsState extends RegistrationState {
  @override
  List<Object?> get props => throw [identityHashCode(this)];
}

class RegistrationErrorMessageState extends RegistrationState {
  final String message;

  RegistrationErrorMessageState({required this.message});

  @override
  List<Object?> get props => [identityHashCode(message)];
}

class RegistrationSuccessState extends RegistrationState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class RegistrationNextLoginPageState extends RegistrationState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class RegistrationLoadingState extends RegistrationState {
  final bool isShow;

  RegistrationLoadingState(this.isShow);

  @override
  List<Object?> get props => [identityHashCode(isShow)];
}
