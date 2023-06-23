import 'package:fitness_app/presentation/constants/color_constants.dart';
import 'package:fitness_app/presentation/constants/path_constants.dart';
import 'package:fitness_app/presentation/constants/text_constants.dart';
import 'package:fitness_app/data/models/workouts/workouts_model.dart';
import 'package:fitness_app/presentation/screens/workout_steps/widget/exercises_list.dart';
import 'package:fitness_app/presentation/screens/workout_steps/widget/workout_steps_info.dart';
import 'package:flutter/material.dart';

class WorkoutStepsContent extends StatelessWidget {
  final Workout workout;

  const WorkoutStepsContent({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: _getMainContent(context),
    );
  }

  Widget _getMainContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getHeader(context),
              const SizedBox(height: 20),
              _getWorkoutData(),
              SizedBox(height: 20),
              _getExerciseList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: ColorConstants.turquoise,
              )),
          Text(
            workout.title! + " " + TextConstants.workoutsText,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getWorkoutData() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          WorkoutStepsInfo(
            icon: PathConstants.clock,
            text: "${workout.minutes}:00 mins",
          ),
          const SizedBox(width: 10),
          WorkoutStepsInfo(
            icon: PathConstants.training,
            text: "${workout.exercises} ${TextConstants.exercises}",
          ),
        ],
      ),
    );
  }

  Widget _getExerciseList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ExercisesList(
            exercises: workout.workoutDetailsList!, workout: workout),
      ),
    );
  }
}
