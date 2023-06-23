import 'dart:convert';
import 'package:fitness_app/presentation/constants/global_constants.dart';
import 'package:fitness_app/data/data_sources/workouts_local_data_source.dart';
import 'package:fitness_app/data/models/workouts/workouts_model.dart';

import '../../domain/repositories/workouts_repository.dart';

class WorkoutsRepositoryImpl implements WorkoutsRepository {
  final WorkoutsLocalDataSource workoutsLocalDataSource;

  WorkoutsRepositoryImpl(this.workoutsLocalDataSource);

  @override
  Future<List<Workout>> getWorkoutsForUser() async {
    final currentUserEmail = GlobalConstants.currentUser.email;
    final workoutsStr =
        await workoutsLocalDataSource.getData('${currentUserEmail}Workouts');
    if (workoutsStr == null) return [];
    final decoded = (json.decode(workoutsStr) as List?) ?? [];
    final workouts = decoded.map((e) {
      final decodedE = json.decode(e) as Map<String, dynamic>?;
      return Workout.fromJson(decodedE!);
    }).toList();
    GlobalConstants.workouts = workouts;
    return workouts;
  }

  @override
  Future saveWorkout(Workout workout) async {
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
    await workoutsLocalDataSource.createData(
      '${currentUserEmail}Workouts',
      encoded,
    );
  }

  @override
  Future clearData() async {
    final currentUserEmail = GlobalConstants.currentUser.email;
    await workoutsLocalDataSource.deleteData('${currentUserEmail}Workouts');
  }
}
