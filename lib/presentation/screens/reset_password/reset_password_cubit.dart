import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:fitness_app/core/services/auth_service.dart';
import 'package:fitness_app/domain/use_cases/auth/reset_password_use_case.dart';
import 'package:flutter/material.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordUseCase _resetPasswordUseCase;
  ResetPasswordCubit(this._resetPasswordUseCase)
      : super(ResetPasswordInitialState());

  final emailController = TextEditingController();
  bool isError = false;

  void resetPassword() async {
    try {
      final map = <String, String>{
        'email': emailController.text,
      };
      emit(ResetPasswordLoading());
      await _resetPasswordUseCase.call(params: map);
      // await AuthService.resetPassword(emailController.text);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordError(message: e.toString()));
    }
  }
}
