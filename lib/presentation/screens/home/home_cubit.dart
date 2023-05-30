import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/data/workouts_data.dart';
import 'package:fitness_app/data/workouts_details_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  String? userName;
  String? photoUrl;

  final User? user = FirebaseAuth.instance.currentUser;

  getUserData() async {
    userName = user?.displayName ?? "No Username";
    photoUrl = user?.photoURL;

    emit(HomeFillDataState(userName: userName, photoURL: photoUrl));
  }

  List<WorkoutData> workouts = <WorkoutData>[];
  List<WorkoutDetailsData> exercises = <WorkoutDetailsData>[];
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
    for (final WorkoutData workout in workouts) {
      exercises.addAll(workout.workoutDetailsList!);
    }
    final exercise = exercises.where((e) => e.progress == 1).toList();
    exercise.forEach((e) {
      timeSent += e.minutes!;
    });
    return timeSent;
  }
}
