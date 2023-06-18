// import 'package:fitness_app/data/workouts_details_data.dart';

// class WorkoutModel {
//   WorkoutModel({
//     this.workout,
//   });

//   WorkoutModel.fromJson(dynamic json) {
//     workout =
//         json['workouts'] != null ? Workout.fromJson(json['workouts']) : null;
//   }
//   Workout? workout;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (workout != null) {
//       map['workouts'] = workout?.toJson();
//     }
//     return map;
//   }
// }

// class Workout {
//   Workout({
//     this.id,
//     this.title,
//     this.exercises,
//     this.minutes,
//     this.currentProgress,
//     this.progress,
//     this.image,
//     this.workoutDetailsList,
//   });

//   String? id;
//   String? title;
//   String? exercises;
//   String? minutes;
//   int? currentProgress;
//   int? progress;
//   String? image;
//   List<WorkoutDetailsData>? workoutDetailsList;

//   Workout.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     exercises = json['exercises'];
//     minutes = json['minutes'];
//     currentProgress = json['currentProgress'];
//     progress = json['progress'];
//     image = json['image'];
//     if (json['exerciseDataList'] != null) {
//       List<WorkoutDetailsData> exercises = [];
//       json['exerciseDataList'].forEach((v) {
//         exercises.add(WorkoutDetailsData.fromJson(v));
//       });
//       workoutDetailsList = exercises;
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['exercises'] = this.exercises;
//     data['minutes'] = this.minutes;
//     data['currentProgress'] = this.currentProgress;
//     data['progress'] = this.progress;
//     data['image'] = this.image;
//     if (this.workoutDetailsList != null) {
//       data['exerciseDataList'] =
//           this.workoutDetailsList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
