import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:fitness_app/core/constants/text_constants.dart';
import 'package:fitness_app/data/workouts_data.dart';
import 'package:fitness_app/screens/workouts/workouts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WorkoutsItem extends StatelessWidget {
  final WorkoutData workoutData;
  const WorkoutsItem({Key? key, required this.workoutData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<WorkoutsCubit>(context);
    final progressPercentage =
        (workoutData.currentProgress! / workoutData.progress!) * 100;
    return Container(
      width: double.infinity,
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
              color: ColorConstants.textBlack.withOpacity(0.12),
              blurRadius: 5.0,
              spreadRadius: 1.1)
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: BlocBuilder<WorkoutsCubit, WorkoutsState>(
          builder: (context, state) {
            return InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                cubit.selectWorkout(workoutData);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(workoutData.image!, fit: BoxFit.fill),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(workoutData.title!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 3),
                        Text(
                            "${workoutData.exercises} ${TextConstants.exercises}",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.grey),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2),
                        const SizedBox(height: 3),
                        Text(
                            "${workoutData.minutes} ${TextConstants.minutesLowercase}",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.grey),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 0.0, left: 2),
                      child: CircularPercentIndicator(
                        percent: workoutData.currentProgress! /
                            workoutData.progress!.toInt(),
                        progressColor: ColorConstants.mainColor,
                        backgroundColor: ColorConstants.grey.withOpacity(0.12),
                        radius: 36,
                        lineWidth: 5.5,
                        center: Text('${progressPercentage.toInt()}%'),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
