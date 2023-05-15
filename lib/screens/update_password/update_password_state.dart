part of 'update_password_cubit.dart';

@immutable
abstract class UpdatePasswordState extends Equatable {}

class UpdatePasswordInitialState extends UpdatePasswordState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdatePasswordFillDataState extends UpdatePasswordState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdatePasswordProgressState extends UpdatePasswordState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdatePasswordErrorState extends UpdatePasswordState {
  final String error;
  UpdatePasswordErrorState(this.error);

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdatePasswordSuccessState extends UpdatePasswordState {
  final String message;
  UpdatePasswordSuccessState({required this.message});

  @override
  List<Object?> get props => [identityHashCode(this)];
}
