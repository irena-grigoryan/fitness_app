import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/presentation/constants/data_constants.dart';
import 'package:fitness_app/data/models/workouts/workouts_model.dart';
import 'package:fitness_app/domain/use_cases/workouts/get_workouts_use_case.dart';
import 'package:flutter/material.dart';

part 'workouts_state.dart';

class WorkoutsCubit extends Cubit<WorkoutsState> {
  GetWorkoutsUseCase _getWorkoutsUseCase;
  WorkoutsCubit(this._getWorkoutsUseCase) : super(WorkoutsInitialState());

  List<Workout> workouts = DataConstants.workouts;

  selectWorkout(workout) {
    emit(WorkoutsOnSelectState(workout: workout));
  }

  getWorkouts() async {
    var workoutsData = await _getWorkoutsUseCase.call();

    for (int i = 0; i < workouts.length; i++) {
      final workoutsUserIndex =
          workoutsData.indexWhere((w) => w.id == workouts[i].id);

      if (workoutsData.length == 0) {
        workouts[i].currentProgress = 0;

        for (int j = 0; j < workouts[i].workoutDetailsList!.length; j++) {
          workouts[i].workoutDetailsList![j].progress = 0;
        }
      } else if (workoutsUserIndex != -1) {
        workouts[i] = workoutsData[workoutsUserIndex];
      }
    }
    emit(WorkoutsReloadState(workouts: workouts));
  }
}
