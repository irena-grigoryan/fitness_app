import 'dart:async';

import 'package:fitness_app/base/use_case.dart';
import 'package:fitness_app/domain/repositories/auth_repository.dart';

class DeactivateUseCase extends UseCase<dynamic, Map<String, String>> {
  AuthRepository authRepository;

  DeactivateUseCase(this.authRepository);

  @override
  Future call({params}) => authRepository.deactivate();
}
