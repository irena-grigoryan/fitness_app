import 'package:fitness_app/data/workouts_data.dart';
import 'package:fitness_app/screens/start_workout/workout_start_screen.dart';
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
      create: (context) => WorkoutStepsCubit(workout)..getInitialData(workout),
      child: BlocConsumer<WorkoutStepsCubit, WorkoutStepsState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<WorkoutStepsCubit>(context);
          return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: AppButton(
                  title: workout.currentProgress == 0 ? 'Start' : 'Continue',
                  onTap: () {
                    final index = workout.currentProgress ==
                            workout.workoutDetailsList!.length
                        ? 0
                        : workout.currentProgress;
                    cubit.onStartTap(currentIndex: index);
                  },
                ),
              ),
              body: WorkoutStepsContent(workout: workout));
        },
        listener: (context, state) async {
          final cubit = BlocProvider.of<WorkoutStepsCubit>(context);

          if (state is WorkoutStepsStartState) {
            final workout = state.isReplace!
                ? await Navigator.of(context, rootNavigator: true)
                    .pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) =>
                            BlocProvider.of<WorkoutStepsCubit>(context),
                        child: WorkoutStartScreen(
                          workout: state.workout,
                          index: state.index,
                        ),
                      ),
                    ),
                  )
                : await Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) =>
                            BlocProvider.of<WorkoutStepsCubit>(context),
                        child: WorkoutStartScreen(
                          workout: state.workout,
                          index: state.index,
                        ),
                      ),
                    ),
                  );
            if (workout is WorkoutData) {
              cubit.getInitialData(workout);
            }
          }
        },
      ),
    );
  }
}
