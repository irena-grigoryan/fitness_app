import 'package:fitness_app/presentation/constants/color_constants.dart';
import 'package:fitness_app/presentation/constants/text_constants.dart';
import 'package:fitness_app/data/models/workouts/workouts_model.dart';
import 'package:fitness_app/presentation/screens/workouts/widget/workouts_item.dart';
import 'package:fitness_app/presentation/screens/workouts/workouts_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsContent extends StatelessWidget {
  const WorkoutsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.backgroundColor,
      height: double.infinity,
      width: double.infinity,
      child:
          BlocBuilder<WorkoutsCubit, WorkoutsState>(builder: (context, state) {
        if (state is WorkoutsReloadState) {
          return _getMainContent(context);
        } else {
          return Center(
              child: CupertinoActivityIndicator(
            radius: 17,
          ));
        }
      }),
    );
  }

  Widget _getMainContent(BuildContext context) {
    final cubit = BlocProvider.of<WorkoutsCubit>(context);
    return BlocBuilder<WorkoutsCubit, WorkoutsState>(
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
                  children:
                      cubit.workouts.map((e) => _getWorkoutItem(e)).toList(),
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
