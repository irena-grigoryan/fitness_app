import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:fitness_app/core/constants/text_constants.dart';
import 'package:fitness_app/presentation/screens/notifications/notifications_cubit.dart';
import 'package:fitness_app/presentation/screens/notifications/widget/notifications_content.dart';
import 'package:fitness_app/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/di/dependency_injections.dart' as di;

class NotificationsScreen extends StatefulWidget {
  static const routeName = '/notifications';

  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsCubit>(
      create: (context) => di.sl(),
      child: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          return Scaffold(
            body: _buildContext(context),
            appBar: AppBar(
              centerTitle: false,
              titleSpacing: 0,
              title: Text(
                TextConstants.notifications,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: ColorConstants.mainColor,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: AppButton(
                title: TextConstants.save,
                onTap: () {
                  final cubit = BlocProvider.of<NotificationsCubit>(context);
                  cubit.onSaveTapped();
                },
              ),
            ),
          );
        },
      ),
    );
  }

  BlocConsumer<NotificationsCubit, NotificationsState> _buildContext(
      BuildContext context) {
    final cubit = BlocProvider.of<NotificationsCubit>(context);
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        if (state is NotificationsInitialState) {
          cubit.reminderNotificationTime(
            dateTime: DateTime.now(),
          );
        }
        return NotificationsContent();
      },
      listener: (context, state) {
        if (state is NotificationsOnSavedState) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
