import 'dart:async';

import 'package:fitness_app/base/use_case.dart';
import 'package:fitness_app/domain/repositories/user_repository.dart';

class UpdatePasswordUseCase extends UseCase<dynamic, Map<String, String>> {
  UserRepository profileRepository;

  UpdatePasswordUseCase(this.profileRepository);

  @override
  Future call({Map<String, String>? params}) =>
      profileRepository.updatePassword(params!['password'] ?? '');
}
