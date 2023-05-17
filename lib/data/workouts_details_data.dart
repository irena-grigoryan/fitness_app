class WorkoutDetailsData {
  final String? title;
  final int? minutes;
  final double? progress;
  final String? video;
  final String? description;
  final List<String>? steps;

  WorkoutDetailsData({
    this.title,
    this.minutes,
    this.progress,
    this.video,
    this.description,
    this.steps,
  });

  @override
  String toString() {
    return 'WorkoutDetailsData(title: $title, minutes: $minutes, progress: $progress, video: $video)';
  }
}
