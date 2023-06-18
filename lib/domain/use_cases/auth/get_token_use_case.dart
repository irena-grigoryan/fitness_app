import 'dart:async';

import 'package:fitness_app/base/use_case.dart';
import 'package:fitness_app/domain/repositories/auth_repository.dart';

class GetTokenUseCase extends UseCase<dynamic, dynamic> {
  AuthRepository authRepository;

  GetTokenUseCase(this.authRepository);

  @override
  Future call({params}) => authRepository.getToken();
}
