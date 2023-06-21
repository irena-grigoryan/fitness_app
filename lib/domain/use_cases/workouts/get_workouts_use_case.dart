import 'dart:async';
import 'package:fitness_app/base/use_case.dart';
import 'package:fitness_app/data/models/workouts/workouts_model.dart';
import 'package:fitness_app/domain/repositories/workouts_repository.dart';

class GetWorkoutsUseCase extends UseCase<dynamic, Workout> {
  WorkoutsRepository workoutsRepository;

  GetWorkoutsUseCase(this.workoutsRepository);

  @override
  Future call({Workout? params}) => workoutsRepository.getWorkoutsForUser();
}
