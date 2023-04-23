import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'workouts_state.dart';

class WorkoutsCubit extends Cubit<WorkoutsState> {
  WorkoutsCubit() : super(WorkoutsInitialState());
}
