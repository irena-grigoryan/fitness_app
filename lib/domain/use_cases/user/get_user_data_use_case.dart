import 'dart:async';

import 'package:fitness_app/base/use_case.dart';
import 'package:fitness_app/domain/entities/user_entity.dart';
import 'package:fitness_app/domain/repositories/user_repository.dart';

class GetUserDataUseCase extends UseCase<UserEntity, dynamic> {
  UserRepository userRepository;

  GetUserDataUseCase(this.userRepository);

  @override
  Future<UserEntity> call({params}) => userRepository.getUserData();
}
