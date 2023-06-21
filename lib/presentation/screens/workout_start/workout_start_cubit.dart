import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/data/models/workouts/workouts_model.dart';
import 'package:fitness_app/domain/use_cases/workouts/save_workouts_use_case.dart';
import 'package:flutter/material.dart';

part 'workout_start_state.dart';

class WorkoutStartCubit extends Cubit<WorkoutStartState> {
  SaveWorkoutsUseCase _saveWorkoutsUseCase;
  WorkoutStartCubit(this._saveWorkoutsUseCase)
      : super(WorkoutStartInitialState());

  saveWorkout(Workout workout) async {
    await _saveWorkoutsUseCase.call(params: workout);
  }
}
