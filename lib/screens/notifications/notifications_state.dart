part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsState extends Equatable {}

class NotificationsInitialState extends NotificationsState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class NotificationsRepeatDayState extends NotificationsState {
  final int? index;

  NotificationsRepeatDayState({required this.index});

  @override
  List<Object?> get props => [identityHashCode(index)];
}

class NotificationsReminderState extends NotificationsState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class NotificationsOnSavedState extends NotificationsState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class NotificationsErrorState extends NotificationsState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
