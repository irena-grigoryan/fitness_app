import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'workout_start_state.dart';

class WorkoutStartCubit extends Cubit<WorkoutStartState> {
  WorkoutStartCubit() : super(WorkoutStartInitialState());
}
