import 'package:fitness_app/data/data_sources/workouts_local_data_source.dart';
import 'package:fitness_app/data/workouts_data.dart';

import '../../domain/repositories/workouts_repository.dart';

class WorkoutsRepositoryImpl implements WorkoutsRepository {
  final WorkoutsLocalDataSource workoutsLocalDataSource;

  WorkoutsRepositoryImpl(this.workoutsLocalDataSource);

  @override
  Future<List<WorkoutData>> getWorkoutsForUser() =>
      workoutsLocalDataSource.getWorkoutsForUser();

  @override
  Future saveWorkout(WorkoutData workout) =>
      workoutsLocalDataSource.saveWorkout(workout);

  @override
  Future clearData() => workoutsLocalDataSource.clearData();
}
