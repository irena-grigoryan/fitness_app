import 'package:fitness_app/data/workouts_data.dart';
import 'package:fitness_app/screens/start_workout/widget/workout_start_content.dart';
import 'package:flutter/material.dart';

class WorkoutStartScreen extends StatelessWidget {
  final WorkoutData? workout;
  final int? index;

  WorkoutStartScreen({
    this.workout,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return const WorkoutStartContent();
  }
}
