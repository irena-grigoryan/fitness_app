import 'package:fitness_app/data/workouts_data.dart';
import 'package:fitness_app/presentation/screens/workout_start/widget/workout_start_content.dart';
import 'package:fitness_app/presentation/screens/workout_start/workout_start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/di/dependency_injections.dart' as di;

class WorkoutStartScreen extends StatelessWidget {
  final WorkoutData? workout;
  final int? index;

  WorkoutStartScreen({
    this.workout,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<WorkoutStartCubit> _buildContext(BuildContext context) {
    return BlocProvider<WorkoutStartCubit>(
      create: (context) => di.sl(),
      child: BlocConsumer<WorkoutStartCubit, WorkoutStartState>(
        listener: (context, state) {},
        builder: (context, state) {
          final currentExercise = workout!.workoutDetailsList![index!];
          final nextExercise = index! + 1 < workout!.workoutDetailsList!.length
              ? workout!.workoutDetailsList![index! + 1]
              : null;
          return WorkoutStartContent(
            workout: workout!,
            exercise: currentExercise,
            nextExercise: nextExercise,
          );
        },
      ),
    );
  }
}
