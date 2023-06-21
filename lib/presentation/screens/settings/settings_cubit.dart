import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/user_entity.dart';
import 'package:fitness_app/domain/use_cases/auth/deactivate_use_case.dart';
import 'package:fitness_app/domain/use_cases/auth/log_out_use_case.dart';
import 'package:fitness_app/domain/use_cases/user/get_user_data_use_case.dart';
import 'package:flutter/material.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  GetUserDataUseCase _getUserDataUseCase;
  LogOutUseCase _logOutUseCase;
  DeactivateUseCase _deactivateUseCase;
  SettingsCubit(
      this._logOutUseCase, this._deactivateUseCase, this._getUserDataUseCase)
      : super(SettingsInitialState());

  getUserData() async {
    try {
      final UserEntity? userData = await _getUserDataUseCase.call();
      if (!isClosed) {
        emit(SettingsFillDataState(userData!));
      }
    } catch (e) {
      emit(SettingsErrorFillDataState());
    }
  }

  void logout() async {
    emit(SettingsLoadingState(true));
    try {
      await Future.delayed(Duration(seconds: 1));
      await _logOutUseCase.call();
      // AuthService.logOut();
      emit(SettingsLoadingState(false));
      emit(SettingsLogoutState());
    } catch (e) {
      print(e);
    }
  }

  void deactivateAccount() async {
    emit(SettingsLoadingState(true));
    try {
      await Future.delayed(Duration(seconds: 1));
      await _deactivateUseCase.call();
      // AuthService.deactivateAccount();
      emit(SettingsLoadingState(false));
      emit(SettingsDeactivateAccountState());
    } catch (e) {
      print(e);
    }
  }
}
