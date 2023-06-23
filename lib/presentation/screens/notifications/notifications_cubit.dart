import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitialState());

  int? selectedRepeatDayIndex;
  DateTime? reminderTime;
  int? selectedDayTime;

  final User? user = FirebaseAuth.instance.currentUser;

  void repeatDaySelected({index, dayTime}) {
    selectedRepeatDayIndex = index;
    selectedDayTime = dayTime;
    emit(NotificationsRepeatDayState(index: selectedRepeatDayIndex));
  }

  void reminderNotificationTime({dateTime}) async {
    reminderTime = dateTime;

    emit(NotificationsReminderState());
  }

  void onSaveTapped() async {
    if (reminderTime != null && selectedDayTime != null) {
      await _schedule(reminderTime!, selectedDayTime);
      emit(NotificationsOnSavedState());
    } else {
      emit(NotificationsErrorState());
    }
  }

  Future _schedule(DateTime dateTime, int? dayTime) async {
    final flutterNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Channel id',
      'Channel name',
    );
    final iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterNotificationsPlugin.zonedSchedule(
      1,
      "Fitness",
      "Hey! It's time to start exercising!",
      _scheduleWeekly(dateTime, days: _getNotificationDay(dayTime)),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  tz.TZDateTime _scheduleDaily(DateTime dateTime) {
    final now = tz.TZDateTime.now(tz.local);
    var timezoneOffset = DateTime.now().timeZoneOffset;
    final scheduleDate = tz.TZDateTime.utc(now.year, now.month, now.day)
        .add(Duration(hours: dateTime.hour, minutes: dateTime.minute))
        .subtract(Duration(hours: timezoneOffset.inHours));

    return scheduleDate.isBefore(now)
        ? scheduleDate.add(Duration(days: 1))
        : scheduleDate;
  }

  tz.TZDateTime _scheduleWeekly(DateTime dateTime, {required List<int>? days}) {
    tz.TZDateTime scheduleDate = _scheduleDaily(dateTime);

    for (final int day in days ?? []) {
      scheduleDate = scheduleDate.add(Duration(days: day));
    }

    return scheduleDate;
  }

  List<int> _getNotificationDay(int? dayTime) {
    switch (dayTime) {
      case 0:
        return [
          DateTime.monday,
          DateTime.tuesday,
          DateTime.wednesday,
          DateTime.thursday,
          DateTime.friday,
          DateTime.saturday,
          DateTime.sunday
        ];
      case 1:
        return [
          DateTime.monday,
          DateTime.tuesday,
          DateTime.wednesday,
          DateTime.thursday,
          DateTime.friday
        ];
      case 2:
        return [DateTime.saturday, DateTime.sunday];
      case 3:
        return [DateTime.monday];
      case 4:
        return [DateTime.tuesday];
      case 5:
        return [DateTime.wednesday];
      case 6:
        return [DateTime.thursday];
      case 7:
        return [DateTime.friday];
      case 8:
        return [DateTime.saturday];
      case 9:
        return [DateTime.sunday];
      default:
        return [];
    }
  }
}
