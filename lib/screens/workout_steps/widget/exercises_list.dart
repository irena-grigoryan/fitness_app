import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:fitness_app/core/constants/path_constants.dart';
import 'package:fitness_app/data/workouts_data.dart';
import 'package:fitness_app/data/workouts_details_data.dart';
import 'package:fitness_app/screens/workout_steps/workout_steps_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExercisesList extends StatelessWidget {
  final WorkoutData workout;
  final List<WorkoutDetailsData> exercises;

  const ExercisesList({required this.exercises, required this.workout});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 10),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return ExerciseItem(
          currentExercise: exercises[index],
          nextExercise:
              index == exercises.length - 1 ? null : exercises[index + 1],
          workout: workout,
          index: index,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 15);
      },
    );
  }
}

class ExerciseItem extends StatelessWidget {
  final WorkoutData workout;
  final WorkoutDetailsData currentExercise;
  final WorkoutDetailsData? nextExercise;
  final int index;

  const ExerciseItem({
    required this.currentExercise,
    required this.workout,
    required this.nextExercise,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<WorkoutStepsCubit>(context);
    return BlocBuilder<WorkoutStepsCubit, WorkoutStepsState>(
      builder: (context, state) {
        return InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: () {
            cubit.onStartTap(currentWorkout: workout, currentIndex: index);
          },
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 10, right: 25, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: ColorConstants.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.textBlack.withOpacity(0.12),
                  blurRadius: 5.0,
                  spreadRadius: 1.1,
                ),
              ],
            ),
            child: Row(
              children: [
                _getImage(),
                const SizedBox(width: 10),
                Expanded(
                  child: _getExerciseTextInfo(),
                ),
                const SizedBox(width: 10),
                _getPlayIcon(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getImage() {
    return Container(
      width: 75,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: AssetImage(workout.image!),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _getExerciseTextInfo() {
    final minutes = "${currentExercise.minutes} minutes";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          currentExercise.title!,
          style: TextStyle(
            color: ColorConstants.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          minutes,
          style: TextStyle(
            color: ColorConstants.textBlack,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _getPlayIcon() {
    return CircularPercentIndicator(
      percent: currentExercise.progress!,
      progressColor: ColorConstants.mainColor,
      backgroundColor: ColorConstants.grey.withOpacity(0.12),
      radius: 24,
      center: Image(
        image: AssetImage(PathConstants.play),
      ),
    );
  }
}
