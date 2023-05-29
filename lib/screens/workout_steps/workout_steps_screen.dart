import 'package:fitness_app/data/workouts_data.dart';
import 'package:fitness_app/screens/workout_steps/widget/workout_steps_content.dart';
import 'package:fitness_app/screens/workout_steps/workout_steps_cubit.dart';
import 'package:fitness_app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fitness_app/di/dependency_injections.dart' as di;

class WorkoutStepsScreen extends StatelessWidget {
  final WorkoutData workout;
  WorkoutStepsScreen({required this.workout});

  @override
  Widget build(BuildContext context) {
    return _buildContext(context);
  }

  BlocProvider<WorkoutStepsCubit> _buildContext(BuildContext context) {
    return BlocProvider<WorkoutStepsCubit>(
      create: (context) => WorkoutStepsCubit(workout),
      child: BlocConsumer<WorkoutStepsCubit, WorkoutStepsState>(
        builder: (context, state) {
          return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: AppButton(
                  title: 'Start',
                  onTap: () {
                    // action
                  },
                ),
              ),
              body: WorkoutStepsContent(workout: workout));
        },
        listener: (context, state) {},
      ),
    );
  }
}
