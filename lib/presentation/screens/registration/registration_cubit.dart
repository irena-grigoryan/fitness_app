// import 'package:fitness_app/core/services/auth_service.dart';
import 'package:fitness_app/core/services/validation_service.dart';
// import 'package:fitness_app/domain/use_cases/auth/create_user_use_case.dart';
import 'package:fitness_app/domain/use_cases/auth/registration_use_case.dart';
import 'package:fitness_app/domain/use_cases/user/update_user_name_use_case.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final RegistrationUseCase _registrationUseCase;
  // final CreateUserUseCase _createUserUseCase;
  final UpdateUserNameUseCase _updateUserNameUseCase;
  RegistrationCubit(
      this._registrationUseCase,
      // , this._createUserUseCase,
      this._updateUserNameUseCase)
      : super(RegistrationInitial());

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isButtonEnabled = false;

  void registration() async {
    if (checkValidatorsOfTextField()) {
      emit(RegistrationLoadingState(true));
      try {
        final map = <String, String>{
          'email': emailController.text,
          'password': passwordController.text,
        };
        final userName = <String, String>{
          'displayName': userNameController.text,
        };
        await _registrationUseCase.call(params: map);
        // await _createUserUseCase.call(params: user);
        await _updateUserNameUseCase.call(params: userName);

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
