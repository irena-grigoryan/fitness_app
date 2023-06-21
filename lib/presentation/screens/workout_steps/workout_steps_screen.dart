import 'package:fitness_app/data/models/workouts/workouts_model.dart';
import 'package:fitness_app/presentation/screens/workout_start/workout_start_screen.dart';
import 'package:fitness_app/presentation/screens/workout_steps/widget/workout_steps_content.dart';
import 'package:fitness_app/presentation/screens/workout_steps/workout_steps_cubit.dart';
import 'package:fitness_app/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/di/dependency_injections.dart' as di;

class WorkoutStepsScreen extends StatefulWidget {
  static const routeName = 'workout_steps';
  // final WorkoutData? workout;

  WorkoutStepsScreen(
      // this.workout
      );

  @override
  State<WorkoutStepsScreen> createState() => _WorkoutStepsScreenState();
}

class _WorkoutStepsScreenState extends State<WorkoutStepsScreen> {
  Workout? workout;
  @override
  Widget build(BuildContext context) {
    return _buildContext(context);
  }

  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Workout>;
    workout = args['workout'];
    super.didChangeDependencies();
  }

  BlocProvider<WorkoutStepsCubit> _buildContext(BuildContext context) {
    return BlocProvider<WorkoutStepsCubit>(
      create: (context) => di.sl()..getInitialData(workout),
      child: BlocConsumer<WorkoutStepsCubit, WorkoutStepsState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<WorkoutStepsCubit>(context);
          cubit.getInitialData(workout);
          return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: AppButton(
                  title: workout!.currentProgress == 0 ? 'Start' : 'Continue',
                  onTap: () {
                    final index = workout!.currentProgress ==
                            workout!.workoutDetailsList!.length
                        ? 0
                        : workout!.currentProgress;
                    cubit.onStartTap(currentIndex: index);
                  },
                ),
              ),
              body: WorkoutStepsContent(workout: workout!));
        },
        listener: (context, state) async {
          final cubit = BlocProvider.of<WorkoutStepsCubit>(context);

          if (state is WorkoutStepsStartState) {
            final workout = state.isReplace!
                ? Navigator.of(context, rootNavigator: true).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<WorkoutStepsCubit>(context),
                        child: WorkoutStartScreen(
                          workout: state.workout!,
                          index: state.index!,
                        ),
                      ),
                    ),
                  )
                : await Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<WorkoutStepsCubit>(context),
                        child: WorkoutStartScreen(
                          workout: state.workout!,
                          index: state.index!,
                        ),
                      ),
                    ),
                  );
            if (workout is Workout) {
              cubit.getInitialData(workout);
            }
          }
        },
      ),
    );
  }
}
