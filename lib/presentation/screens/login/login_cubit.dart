import 'package:fitness_app/data/services/firebase_service.dart';
import 'package:fitness_app/data/services/validation_service.dart';
import 'package:fitness_app/domain/use_cases/auth/login_use_case.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginUseCase _loginUseCase;
  LoginCubit(this._loginUseCase) : super(LoginInitialState());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isButtonEnabled = false;

  login() async {
    if (_checkValidatorsOfTextField()) {
      emit(LoginLoadingState());
      try {
        final map = <String, String>{
          'email': emailController.text,
          'password': passwordController.text,
        };
        await _loginUseCase.call(params: map);

        await FirebaseService.login(
            emailController.text, passwordController.text);
        emit(LoginNextMainScreenState());
      } catch (e) {
        emit(LoginErrorState(message: e.toString()));
      }
    } else {
      emit(LoginShowErrorState());
    }
  }

  void resetPassword() {
    emit(LoginNextResetPasswordScreenState());
  }

  void nextRegistrationScreen() {
    emit(LoginNextRegistrationScreenState());
  }

  void onTextChanged() {
    if (isButtonEnabled != _checkIfButtonEnabled()) {
      isButtonEnabled = _checkIfButtonEnabled();
      emit(LoginButtonEnableChangedState(isEnabled: isButtonEnabled));
    }
  }

  bool _checkIfButtonEnabled() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  bool _checkValidatorsOfTextField() {
    return ValidationService.isEmailValid(emailController.text) &&
        ValidationService.isPasswordValid(passwordController.text);
  }
}
