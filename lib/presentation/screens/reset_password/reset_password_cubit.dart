import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/services/auth_service.dart';
import 'package:flutter/material.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitialState());

  final emailController = TextEditingController();
  bool isError = false;

  void resetPassword() async {
    try {
      emit(ResetPasswordLoading());
      await AuthService.resetPassword(emailController.text);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordError(message: e.toString()));
    }
  }
}
