import 'package:flutter/material.dart';
import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:fitness_app/core/constants/path_constants.dart';
import 'package:fitness_app/data/workouts_data.dart';
import 'package:fitness_app/data/workouts_details_data.dart';
import 'package:fitness_app/presentation/screens/workout_start/workout_start_cubit.dart';
import 'package:fitness_app/presentation/widgets/app_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class WorkoutStartContent extends StatelessWidget {
  final WorkoutData workout;
  final WorkoutDetailsData exercise;
  final WorkoutDetailsData? nextExercise;

  WorkoutStartContent({
    required this.workout,
    required this.exercise,
    required this.nextExercise,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: SafeArea(
        child: Scaffold(body: _getSlidingUpPanel(context)),
      ),
    );
  }

  Widget _getSlidingUpPanel(BuildContext context) {
    return SlidingUpPanel(
      panel: _getPanel(context),
      body: _getBody(context),
      isDraggable: true,
      minHeight: MediaQuery.of(context).size.height * 0.60,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
    );
  }

  Widget _getPanel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getSwipe(),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(children: [
              const SizedBox(height: 9),
              _getExercisesSteps(),
            ]),
          ),
          const SizedBox(height: 18),
          _getButton(context),
        ],
      ),
    );
  }

  Widget _getBody(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getBackButton(context),
                const SizedBox(width: 16),
                _getTitle(),
              ],
            ),
            const SizedBox(height: 23),
          ],
        ));
  }

  Widget _getSwipe() {
    return Center(
      child: Image.asset(
        PathConstants.swipe,
      ),
    );
  }

  Widget _getBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 8),
      child: GestureDetector(
        child: BlocBuilder<WorkoutStartCubit, WorkoutStartState>(
          builder: (context, state) {
            return Icon(
              Icons.arrow_back_ios,
              color: ColorConstants.mainColor,
            );
          },
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _getTitle() {
    return Text(exercise.title ?? "",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
  }

  Widget _getExercisesSteps() {
    return Column(
      children: [
        for (int i = 0; i < exercise.steps!.length; i++) ...[
          ExerciseStep(number: "${i + 1}", description: exercise.steps![i]),
          const SizedBox(height: 20),
        ],
      ],
    );
  }

  Widget _getButton(BuildContext context) {
    return AppButton(
      title: nextExercise != null ? 'Next' : 'Finish',
      onTap: () {
        // action
      },
    );
  }
}

class ExerciseStep extends StatelessWidget {
  final String number;
  final String description;

  ExerciseStep({required this.number, required this.description});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: ColorConstants.mainColor.withOpacity(0.12),
          ),
          child: Center(
              child: Text(number,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.mainColor))),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(description)),
      ],
    );
  }
}