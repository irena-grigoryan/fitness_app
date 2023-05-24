import 'dart:convert';

import 'package:fitness_app/data/workouts_details_data.dart';

class WorkoutData {
  String? id;
  String? title;
  String? exercises;
  String? minutes;
  int? currentProgress;
  int? progress;
  String? image;
  List<WorkoutDetailsData>? workoutDetailsList;

  WorkoutData({
    this.id,
    this.title,
    this.exercises,
    this.minutes,
    this.currentProgress,
    this.progress,
    this.image,
    this.workoutDetailsList,
  });

  WorkoutData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    exercises = json['exercises'];
    minutes = json['minutes'];
    currentProgress = json['currentProgress'];
    progress = json['progress'];
    image = json['image'];
    if (json['exerciseDataList'] != null) {
      List<WorkoutDetailsData> exercises = [];
      json['exerciseDataList'].forEach((v) {
        exercises.add(WorkoutDetailsData.fromJson(v));
      });
      workoutDetailsList = exercises;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['exercises'] = this.exercises;
    data['minutes'] = this.minutes;
    data['currentProgress'] = this.currentProgress;
    data['progress'] = this.progress;
    data['image'] = this.image;
    if (this.workoutDetailsList != null) {
      data['exerciseDataList'] =
          this.workoutDetailsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String toJsonString() {
    final str = json.encode(this.toJson());
    return str;
  }
}
