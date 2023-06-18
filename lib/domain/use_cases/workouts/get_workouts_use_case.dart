import 'dart:async';
import 'package:fitness_app/base/use_case.dart';
import 'package:fitness_app/data/workouts_data.dart';
import 'package:fitness_app/domain/repositories/workouts_repository.dart';

class GetWorkoutsUseCase extends UseCase<dynamic, WorkoutData> {
  WorkoutsRepository workoutsRepository;

  GetWorkoutsUseCase(this.workoutsRepository);

  @override
  Future call({WorkoutData? params}) => workoutsRepository.getWorkoutsForUser();
}
