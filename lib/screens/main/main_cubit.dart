import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  int currentIndex = 1;

  void selectItem(index) async {
    currentIndex = index;
    emit(MainItemSelectedState(index: currentIndex));
  }
}
