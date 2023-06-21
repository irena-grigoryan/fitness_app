part of 'settings_cubit.dart';

@immutable
abstract class SettingsState extends Equatable {}

class SettingsInitialState extends SettingsState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SettingsFillDataState extends SettingsState {
  final UserEntity user;

  SettingsFillDataState(this.user);

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SettingsLoadingState extends SettingsState {
  final bool isShow;

  SettingsLoadingState(this.isShow);
  @override
  List<Object?> get props => [isShow];
}

class SettingsLogoutState extends SettingsState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SettingsDeactivateAccountState extends SettingsState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SettingsErrorFillDataState extends SettingsState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
