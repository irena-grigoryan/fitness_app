import 'package:fitness_app/screens/workout_steps/workout_steps_screen.dart';
import 'package:fitness_app/screens/workouts/widget/workouts_content.dart';
import 'package:fitness_app/screens/workouts/workouts_cubit.dart';
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
      create: (context) => di.sl(),
      child: BlocConsumer<WorkoutsCubit, WorkoutsState>(
        listener: (context, state) {
          if (state is WorkoutsOnSelectState) {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (_) => WorkoutStepsScreen(workout: state.workout),
              ),
            );
          }
        },
        builder: (context, state) {
          return const WorkoutsContent();
        },
      ),
    );
  }
}
