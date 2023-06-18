import 'dart:async';

import 'package:fitness_app/base/use_case.dart';
import 'package:fitness_app/domain/repositories/auth_repository.dart';

class CreateUserUseCase extends UseCase<dynamic, Map<String, String>> {
  AuthRepository authRepository;

  CreateUserUseCase(this.authRepository);

  @override
  Future call({Map<String, String>? params}) => authRepository.createUser(
      params!['email'] ?? '', params['name'] ?? '', params['photoUrl'] ?? '');
}
