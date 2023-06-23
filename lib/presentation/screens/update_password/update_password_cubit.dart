import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/presentation/constants/text_constants.dart';
import 'package:fitness_app/domain/entities/user_entity.dart';
import 'package:fitness_app/domain/use_cases/user/get_user_data_use_case.dart';
import 'package:fitness_app/domain/use_cases/user/update_password_use_case.dart';
import 'package:flutter/material.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordUseCase _updatePasswordUseCase;
  GetUserDataUseCase _getUserDataUseCase;
  UpdatePasswordCubit(this._updatePasswordUseCase, this._getUserDataUseCase)
      : super(UpdatePasswordInitialState());
  String? userName;

  UserEntity? user;

  getUserData() async {
    user = await _getUserDataUseCase.call();
    emit(UpdatePasswordFillDataState(user!));
  }

  updatePassword(password) async {
    emit(UpdatePasswordProgressState());

    final map = <String, String>{
      'password': password,
    };
    try {
      await _updatePasswordUseCase.call(params: map);
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
