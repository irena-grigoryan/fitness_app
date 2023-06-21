import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/data/models/workouts/workouts_model.dart';

class UserData {
  String? name;
  String? photo;
  String? mail;
  List<Workout>? workouts;

  UserData({
    required this.name,
    required this.photo,
    required this.mail,
    required this.workouts,
  });

  UserData.fromJson(dynamic json) {
    name = json['name'];
    photo = json['photo'];
    mail = json['mail'];
    if (json['workouts'] != null) {
      List<Workout> workouts = [];
      json['workouts'].forEach((v) {
        workouts.add(new Workout.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['mail'] = this.mail;
    if (this.workouts != null) {
      data['workouts'] = this.workouts!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static fromFirebase(User? user) {
    return user != null
        ? UserData(
            name: user.displayName ?? "",
            photo: user.photoURL ?? "",
            mail: user.email ?? "",
            workouts: [],
          )
        : [];
  }
}
