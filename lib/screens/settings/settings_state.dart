part of 'settings_cubit.dart';

@immutable
abstract class SettingsState extends Equatable {}

class SettingsInitialState extends SettingsState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
