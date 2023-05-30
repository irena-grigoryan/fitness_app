import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/core/constants/text_constants.dart';
import 'package:fitness_app/core/services/user_service.dart';
import 'package:flutter/material.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit() : super(UpdatePasswordInitialState());
  final User? user = FirebaseAuth.instance.currentUser;
  String? userName;

  getUserData() {
    userName = user?.displayName ?? "No Username";
    emit(UpdatePasswordFillDataState());
  }

  updatePassword(password) async {
    emit(UpdatePasswordProgressState());
    try {
      await UserService.updatePassword(newPass: password);
      emit(UpdatePasswordSuccessState(message: TextConstants.passwordUpdated));
      await Future.delayed(Duration(seconds: 1));
      emit(UpdatePasswordInitialState());
    } catch (e) {
      emit(UpdatePasswordErrorState(e.toString()));
      await Future.delayed(Duration(seconds: 1));
      emit(UpdatePasswordInitialState());
    }
  }
}
