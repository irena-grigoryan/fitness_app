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
        listener: (context, state) {},
        builder: (context, state) {
          return const Scaffold();
        },
      ),
    );
  }
}
