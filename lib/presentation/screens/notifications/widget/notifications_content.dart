import 'package:fitness_app/presentation/constants/color_constants.dart';
import 'package:fitness_app/presentation/constants/data_constants.dart';
import 'package:fitness_app/presentation/constants/text_constants.dart';
import 'package:fitness_app/presentation/screens/notifications/notifications_cubit.dart';
import 'package:fitness_app/presentation/widgets/app_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsContent extends StatefulWidget {
  const NotificationsContent({Key? key}) : super(key: key);

  @override
  State<NotificationsContent> createState() => _NotificationsContentState();
}

class _NotificationsContentState extends State<NotificationsContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ColorConstants.white,
      child: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Dialogs.showInformDialog(
                  context: context, content: TextConstants.notificationsError);
            });
          }
          return _getMainContent(context);
        },
      ),
    );
  }

  Widget _getMainContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getSelectTime(),
              const SizedBox(height: 20),
              _getTimePicker(context),
              const SizedBox(height: 20),
              _getRepeating(),
              const SizedBox(height: 15),
              _getDayRepeating(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getSelectTime() {
    return Text(
      TextConstants.selectTime,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _getTimePicker(BuildContext context) {
    final cubit = BlocProvider.of<NotificationsCubit>(context);
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        return Container(
          height: 250,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            onDateTimeChanged: (DateTime value) {
              cubit.reminderNotificationTime(dateTime: value);
            },
          ),
        );
      },
    );
  }

  Widget _getRepeating() {
    return Text(TextConstants.repeating,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600));
  }

  Widget _getDayRepeating(BuildContext context) {
    final cubit = BlocProvider.of<NotificationsCubit>(context);
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      buildWhen: (context, currState) =>
          currState is NotificationsRepeatDayState,
      builder: (context, state) {
        return Wrap(
          spacing: 10,
          runSpacing: 15,
          children: [
            for (int i = 0; i < DataConstants.days.length; i++) ...[
              RepeatingDay(
                title: DataConstants.days[i],
                isSelected: cubit.selectedRepeatDayIndex == i,
                onTap: () {
                  cubit.repeatDaySelected(
                      index: i, dayTime: cubit.selectedDayTime = i);
                },
              ),
            ],
          ],
        );
      },
    );
  }
}

class RepeatingDay extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  RepeatingDay({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorConstants.mainColor
              : ColorConstants.grey.withOpacity(0.18),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isSelected ? ColorConstants.white : ColorConstants.grey,
          ),
        ),
      ),
    );
  }
}
