import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:fitness_app/core/constants/path_constants.dart';
import 'package:fitness_app/core/constants/text_constants.dart';
import 'package:fitness_app/presentation/screens/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWorkoutProgress extends StatelessWidget {
  const HomeWorkoutProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          _getCompleted(context, cubit),
          SizedBox(height: 20),
          _getStatistics(cubit),
        ],
      ),
    );
  }

  Widget _getCompleted(BuildContext context, HomeCubit cubit) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withOpacity(0.12),
            blurRadius: 5.0,
            spreadRadius: 1.1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Image(
                image: AssetImage(
                  PathConstants.finished,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                TextConstants.finished,
                style: TextStyle(
                  color: ColorConstants.textBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
              // ),
            ],
          ),
          Column(
            children: [
              Text(
                '${cubit.getFinished()}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.textBlack,
                ),
              ),
              Text(
                TextConstants.completed,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getStatistics(HomeCubit cubit) {
    return Row(
      children: [
        DataWorkouts(
          icon: PathConstants.progress,
          title: TextConstants.inProgress,
          count: cubit.getInProgress() ?? 0,
          text: TextConstants.workoutsText,
        ),
        const SizedBox(width: 20),
        DataWorkouts(
          icon: PathConstants.time,
          title: TextConstants.timeSpent,
          count: cubit.getTimeSpent() ?? 0,
          text: TextConstants.minutes,
        ),
      ],
    );
  }
}

class DataWorkouts extends StatelessWidget {
  final String? icon;
  final String? title;
  final int? count;
  final String? text;

  DataWorkouts({
    this.icon,
    this.title,
    this.count,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: ColorConstants.white,
          boxShadow: [
            BoxShadow(
              color: ColorConstants.textBlack.withOpacity(0.12),
              blurRadius: 5.0,
              spreadRadius: 1.1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: AssetImage(icon!)),
            const SizedBox(width: 10),
            Text(
              title!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: ColorConstants.textBlack,
              ),
            ),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: ColorConstants.textBlack,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              text!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorConstants.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
