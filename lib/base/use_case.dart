import 'dart:async';

abstract class UseCase<Type, Params> {
  Future<Type> call({Params? params});
}
