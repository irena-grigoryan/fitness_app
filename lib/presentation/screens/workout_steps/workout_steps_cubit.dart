import 'package:equatable/equatable.dart';
import 'package:fitness_app/data/workouts_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'workout_steps_state.dart';

class WorkoutStepsCubit extends Cubit<WorkoutStepsState> {
  WorkoutStepsCubit() : super(WorkoutStepsInitialState());
  late WorkoutData? workout;

  // WorkoutStepsCubit(WorkoutData workout) : super(WorkoutStepsInitialState());

  // late WorkoutData? workout;

  getInitialData(currentWorkout) {
    workout = currentWorkout;
    emit(WorkoutStepsReloadState(workout: workout!));
  }

  onStartTap(
      {WorkoutData? currentWorkout,
      int? currentIndex,
      bool? currentIsReplace}) {
    emit(WorkoutStepsStartState(
      workout: currentWorkout ?? workout,
      index: currentIndex ?? 0,
      isReplace: currentIsReplace ?? false,
    ));
  }
}
