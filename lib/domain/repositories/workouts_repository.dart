import 'package:fitness_app/data/models/workouts/workouts_model.dart';

abstract class WorkoutsRepository {
  Future<List<Workout>> getWorkoutsForUser();

  Future saveWorkout(Workout workout);
  Future clearData();
}
