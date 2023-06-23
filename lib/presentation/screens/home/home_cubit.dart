import 'package:equatable/equatable.dart';
import 'package:fitness_app/presentation/constants/global_constants.dart';
import 'package:fitness_app/data/models/workouts/workouts_model.dart';
import 'package:fitness_app/data/models/workouts/workouts_details_model.dart';
import 'package:fitness_app/domain/entities/user_entity.dart';
import 'package:fitness_app/domain/use_cases/user/get_user_data_use_case.dart';
import 'package:fitness_app/domain/use_cases/workouts/get_workouts_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  GetUserDataUseCase _getUserDataUseCase;
  GetWorkoutsUseCase _getWorkoutsUseCase;
  HomeCubit(this._getUserDataUseCase, this._getWorkoutsUseCase)
      : super(HomeInitialState());

  String? userName;
  String? photoUrl;

  UserEntity? userData;

  getUserData() async {
    try {
      userData = await _getUserDataUseCase.call();

      GlobalConstants.currentUser = userData!;
      emit(HomeFillDataState(user: userData!));

      workouts = await _getWorkoutsUseCase.call();
    } catch (e) {
      emit(HomeErrorFillDataState());
    }
  }

  List<Workout> workouts = <Workout>[];

  List<WorkoutDetailsModel> exercises = <WorkoutDetailsModel>[];
  int timeSent = 0;

  int? getFinished() {
    final completedWorkouts =
        workouts.where((w) => w.currentProgress == w.progress).toList();
    return completedWorkouts.length;
  }

  int? getInProgress() {
    final completedWorkouts = workouts.where(
        (w) => (w.currentProgress ?? 0) > 0 && w.currentProgress != w.progress);
    return completedWorkouts.length;
  }

  int? getTimeSpent() {
    for (final Workout workout in workouts) {
      exercises.addAll(workout.workoutDetailsList!);
    }
    final exercise = exercises.where((e) => e.progress == 1).toList();
    exercise.forEach((e) {
      timeSent += e.minutes!;
    });
    return timeSent;
  }
}
