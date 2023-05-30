part of 'reset_password_cubit.dart';

@immutable
abstract class ResetPasswordState extends Equatable {}

class ResetPasswordInitialState extends ResetPasswordState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ResetPasswordError extends ResetPasswordState {
  final String message;

  ResetPasswordError({required this.message});

  @override
  List<Object?> get props => [identityHashCode(message)];
}

class ResetPasswordLoading extends ResetPasswordState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ResetPasswordSuccess extends ResetPasswordState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
