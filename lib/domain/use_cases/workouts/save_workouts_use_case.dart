import 'dart:async';

import 'package:fitness_app/base/use_case.dart';
import 'package:fitness_app/data/workouts_data.dart';
import 'package:fitness_app/domain/repositories/workouts_repository.dart';

class SaveWorkoutsUseCase extends UseCase<dynamic, WorkoutData> {
  WorkoutsRepository workoutsRepository;

  SaveWorkoutsUseCase(this.workoutsRepository);

  @override
  Future call({WorkoutData? params}) => workoutsRepository.saveWorkout(params!);
}
