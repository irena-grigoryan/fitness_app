import 'package:fitness_app/data/workouts_data.dart';

abstract class WorkoutsRepository {
  Future<List<WorkoutData>> getWorkoutsForUser();
  Future saveWorkout(WorkoutData workout);
  Future clearData();
}
