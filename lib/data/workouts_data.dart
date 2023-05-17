import 'package:fitness_app/data/workouts_details_data.dart';

class WorkoutData {
  final String? title;
  final String? exercises;
  final String? minutes;
  final int? currentProgress;
  final int? progress;
  final String? image;
  final List<WorkoutDetailsData>? workoutDetailsList;

  WorkoutData({
    this.title,
    this.exercises,
    this.minutes,
    this.currentProgress,
    this.progress,
    this.image,
    this.workoutDetailsList,
  });

  @override
  String toString() {
    return 'WorkoutData(title: $title, exercises: $exercises, minutes: $minutes, currentProgress: $currentProgress, progress: $progress, image: $image, workoutDetailsList: $workoutDetailsList,)';
  }
}
