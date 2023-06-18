import 'dart:convert';

class WorkoutDetailsData {
  String? id;
  String? title;
  int? minutes;
  double? progress;
  String? video;
  List<String>? steps;

  WorkoutDetailsData({
    this.id,
    this.title,
    this.minutes,
    this.progress,
    this.video,
    this.steps,
  });

  WorkoutDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    minutes = json['minutes'];
    progress = json['progress'];
    video = json['video'];
    steps = json['steps'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['minutes'] = this.minutes;
    data['progress'] = this.progress;
    data['video'] = this.video;
    data['steps'] = this.steps;
    return data;
  }

  String toJsonString() {
    final str = json.encode(this.toJson());
    return str;
  }
}
