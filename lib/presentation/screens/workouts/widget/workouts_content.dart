import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:fitness_app/core/constants/data_constants.dart';
import 'package:fitness_app/core/constants/text_constants.dart';
import 'package:fitness_app/data/models/workouts/workouts_model.dart';
import 'package:fitness_app/presentation/screens/workouts/widget/workouts_item.dart';
import 'package:fitness_app/presentation/screens/workouts/workouts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsContent extends StatelessWidget {
  const WorkoutsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.backgroundColor,
      height: double.infinity,
      width: double.infinity,
      child: _getMainContent(context),
    );
  }

  Widget _getMainContent(BuildContext context) {
    return BlocBuilder<WorkoutsCubit, WorkoutsState>(
      buildWhen: (_, currState) => currState is WorkoutsReloadState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TextConstants.workoutsText,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(
                      TextConstants.workoutsSubtitle,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: ListView(
                  children: DataConstants.workouts
                      .map(
                        (e) => _getWorkoutItem(e),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getWorkoutItem(Workout workoutData) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: WorkoutsItem(workoutData: workoutData),
    );
  }
}
