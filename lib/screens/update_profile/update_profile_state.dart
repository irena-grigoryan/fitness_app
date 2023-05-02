part of 'update_profile_cubit.dart';

@immutable
abstract class UpdateProfileState extends Equatable {}

class UpdateProfileInitialState extends UpdateProfileState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdateProfileFillDataState extends UpdateProfileState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdateProfileProgressState extends UpdateProfileState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdateProfileErrorState extends UpdateProfileState {
  final String error;
  UpdateProfileErrorState(this.error);

  @override
  List<Object?> get props => [identityHashCode(error)];
}

class UpdateProfilePhotoSuccessState extends UpdateProfileState {
  final XFile image;
  UpdateProfilePhotoSuccessState(this.image);

  @override
  List<Object?> get props => [identityHashCode(image)];
}

class UpdateProfileSuccessState extends UpdateProfileState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}