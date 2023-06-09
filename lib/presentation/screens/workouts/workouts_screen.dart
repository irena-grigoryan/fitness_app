import 'package:fitness_app/data/models/workouts/workouts_model.dart';
import 'package:fitness_app/presentation/screens/workout_steps/workout_steps_screen.dart';
import 'package:fitness_app/presentation/screens/workouts/widget/workouts_content.dart';
import 'package:fitness_app/presentation/screens/workouts/workouts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/di/dependency_injections.dart' as di;

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutsCubit>(
      create: (context) => di.sl()..getWorkouts(),
      child: BlocConsumer<WorkoutsCubit, WorkoutsState>(
        listener: (context, state) {
          final cubit = BlocProvider.of<WorkoutsCubit>(context);
          if (state is WorkoutsOnSelectState) {
            cubit.getWorkouts();
            onSelect(context, state.workout);
          }
        },
        buildWhen: (context, currState) => currState is WorkoutsReloadState,
        builder: (context, state) {
          final cubit = BlocProvider.of<WorkoutsCubit>(context);
          cubit.getWorkouts();
          return WorkoutsContent();
        },
      ),
    );
  }

  void onSelect(BuildContext context, Workout workout) {
    Navigator.of(context).pushNamed(
      WorkoutStepsScreen.routeName,
      arguments: {
        'workout': workout,
      },
    );
  }
}
