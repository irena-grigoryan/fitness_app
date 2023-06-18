import 'package:fitness_app/data/workouts_data.dart';

class UserModel {
  UserModel({
    this.user,
  });

  UserModel.fromJson(dynamic json) {
    user = json['users'] != null ? User.fromJson(json['users']) : null;
  }
  User? user;

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (user != null) {
      map['users'] = user!.toJson();
    }
    return map;
  }
}

class User {
  User({
    this.id,
    this.email,
    this.name,
    this.photo,
    this.workouts,
  });

  String? id;
  String? email;
  String? name;
  String? photo;
  List<WorkoutData>? workouts;

  User.fromJson(json) {
    Map<String, dynamic> userMap = json[0];

    id = userMap['localId'];
    email = userMap['email'];
    name = userMap['displayName'];
    photo = userMap['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['displayName'] = this.name;
    data['photoUrl'] = this.photo;
    return data;
  }

  static fromFirebase(User? user) {
    return user != null
        ? User(
            name: user.name ?? "",
            photo: user.photo ?? "",
            email: user.email ?? "",
            workouts: [],
          )
        : [];
  }
}
