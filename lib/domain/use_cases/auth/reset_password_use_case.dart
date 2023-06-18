import 'dart:async';

import 'package:fitness_app/base/use_case.dart';
import 'package:fitness_app/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase extends UseCase<dynamic, Map<String, String>> {
  AuthRepository authRepository;

  ResetPasswordUseCase(this.authRepository);

  @override
  Future call({Map<String, String>? params}) =>
      authRepository.resetPassword(params!['email'] ?? '');
}
