import 'package:fitness_app/data/workouts_data.dart';
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
      create: (context) => di.sl()..workoutsInitialEvent(),
      child: BlocConsumer<WorkoutsCubit, WorkoutsState>(
        listener: (context, state) {
          final cubit = BlocProvider.of<WorkoutsCubit>(context);
          if (state is WorkoutsOnSelectState) {
            // Navigator.of(context, rootNavigator: true).push(
            //   MaterialPageRoute(
            //     builder: (_) => WorkoutStepsScreen(workout: state.workout),
            //   ),
            // );
            onSelect(context, state.workout);
            cubit.workoutsInitialEvent();
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<WorkoutsCubit>(context);
          cubit.workoutsInitialEvent();
          return const WorkoutsContent();
        },
      ),
    );
  }

  void onSelect(BuildContext context, WorkoutData workout) {
    Navigator.of(context).pushNamed(
      WorkoutStepsScreen.routeName,
      arguments: {
        'workout': workout,
      },
    );
  }
}
