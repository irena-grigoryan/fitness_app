import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'introduction_state.dart';

class IntroductionCubit extends Cubit<IntroductionState> {
  IntroductionCubit() : super(IntroductionInitial());

  int pageIndex = 0;

  final pageController = PageController(initialPage: 0);

  void nextScreen() async {
    if (pageIndex == 2) {
      emit(IntroductionNextScreenState());
      return;
    }
    pageIndex += 1;

    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );

    emit(IntroductionScreenChangedState(counter: pageIndex));
  }
}
