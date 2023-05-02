import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/services/auth_service.dart';
import 'package:flutter/material.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitialState());

  void logout() async {
    emit(SettingsLoadingState(true));
    try {
      await Future.delayed(Duration(seconds: 2));
      AuthService.logOut();
      emit(SettingsLoadingState(false));
      emit(SettingsLogoutState());
    } catch (e) {
      print(e);
    }
  }

  void deactivateAccount() async {
    emit(SettingsLoadingState(true));
    try {
      await Future.delayed(Duration(seconds: 2));
      AuthService.deactivateAccount();
      emit(SettingsLoadingState(false));
      emit(SettingsDeactivateAccountState());
    } catch (e) {
      print(e);
    }
  }
}
