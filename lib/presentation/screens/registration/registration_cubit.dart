import 'package:fitness_app/core/services/auth_service.dart';
import 'package:fitness_app/core/services/validation_service.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isButtonEnabled = false;

  void registration() async {
    if (checkValidatorsOfTextField()) {
      emit(RegistrationLoadingState(true));
      try {
        await AuthService.registration(emailController.text,
            passwordController.text, userNameController.text);
        emit(RegistrationLoadingState(false));
        emit(RegistrationNextMainScreenState());
      } catch (e) {
        emit(RegistrationErrorMessageState(message: e.toString()));
      }
    } else {
      emit(RegistrationShowErrorState());
    }
  }

  void nextLoginScreen() {
    emit(RegistrationNextLoginPageState());
  }

  void onTextChanged() {
    if (isButtonEnabled != checkIfButtonEnabled()) {
      isButtonEnabled = checkIfButtonEnabled();
      emit(RegistrationButtonEnableChangedState(isEnabled: isButtonEnabled));
    }
  }

  bool checkIfButtonEnabled() {
    return userNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  bool checkValidatorsOfTextField() {
    return ValidationService.isUsernameValid(userNameController.text) &&
        ValidationService.isEmailValid(emailController.text) &&
        ValidationService.isPasswordValid(passwordController.text) &&
        ValidationService.isConfirmPasswordValid(
            passwordController.text, confirmPasswordController.text);
  }
}
