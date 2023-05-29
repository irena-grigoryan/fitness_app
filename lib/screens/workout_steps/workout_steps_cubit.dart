import 'package:equatable/equatable.dart';
import 'package:fitness_app/data/workouts_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'workout_steps_state.dart';

class WorkoutStepsCubit extends Cubit<WorkoutStepsState> {
  WorkoutStepsCubit(WorkoutData workout) : super(WorkoutStepsInitialState());
}
