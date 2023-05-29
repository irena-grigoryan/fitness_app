import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/data/workouts_data.dart';
import 'package:flutter/material.dart';

part 'workouts_state.dart';

class WorkoutsCubit extends Cubit<WorkoutsState> {
  WorkoutsCubit() : super(WorkoutsInitialState());

  selectWorkout(workout) {
    emit(WorkoutsOnSelectState(workout: workout));
  }
}
