import 'dart:convert';

import 'package:fitness_app/core/constants/global_constants.dart';
import 'package:fitness_app/core/services/user_storage_service.dart';
import 'package:fitness_app/data/workouts_data.dart';

abstract class WorkoutsLocalDataSource {
  Future<List<WorkoutData>> getWorkoutsForUser();
  Future saveWorkout(WorkoutData workout);
  Future clearData();
}

class WorkoutsLocalDataSourceImpl implements WorkoutsLocalDataSource {
  @override
  Future<List<WorkoutData>> getWorkoutsForUser() async {
    final currentUserEmail = GlobalConstants.currentUser.email;
    final workoutsStr =
        await UserStorageService.getData('${currentUserEmail}Workouts');
    if (workoutsStr == null) return [];
    final decoded = (json.decode(workoutsStr) as List?) ?? [];
    final workouts = decoded.map((e) {
      final decodedE = json.decode(e) as Map<String, dynamic>?;
      return WorkoutData.fromJson(decodedE!);
    }).toList();
    GlobalConstants.workouts = workouts;
    return workouts;
  }

  @override
  Future saveWorkout(WorkoutData workout) async {
    final allWorkouts = await getWorkoutsForUser();
    final index = allWorkouts.indexWhere((w) => w.id == workout.id);
    if (index != -1) {
      allWorkouts[index] = workout;
    } else {
      allWorkouts.add(workout);
    }
    GlobalConstants.workouts = allWorkouts;
    final workoutsStr = allWorkouts.map((e) => e.toJsonString()).toList();
    final encoded = json.encode(workoutsStr);
    final currentUserEmail = GlobalConstants.currentUser.email;
    await UserStorageService.createData(
      '${currentUserEmail}Workouts',
      encoded,
    );
  }

  @override
  Future clearData() async {
    final currentUserEmail = GlobalConstants.currentUser.email;
    await UserStorageService.deleteData('${currentUserEmail}Workouts');
  }
}
