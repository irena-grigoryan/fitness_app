import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  String? userName;
  String? photoUrl;

  final User? user = FirebaseAuth.instance.currentUser;

  getUserData() {
    userName = user?.displayName ?? "No Username";
    photoUrl = user?.photoURL;
    emit(HomeFillDataState());
  }
}
