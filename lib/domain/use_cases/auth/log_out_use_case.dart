import 'dart:async';

import 'package:fitness_app/base/use_case.dart';
import 'package:fitness_app/domain/repositories/auth_repository.dart';

class LogOutUseCase extends UseCase<dynamic, Map<String, String>> {
  AuthRepository authRepository;

  LogOutUseCase(this.authRepository);

  @override
  Future call({params}) => authRepository.logout();
}
