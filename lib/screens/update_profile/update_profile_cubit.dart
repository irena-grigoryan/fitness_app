import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/core/services/storage_service.dart';
import 'package:fitness_app/core/services/user_service.dart';
import 'package:fitness_app/core/services/user_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitialState());

  final User? user = FirebaseAuth.instance.currentUser;
  late String userName;
  late String userEmail;
  String? photoUrl;

  getUserData() {
    userName = user?.displayName ?? "No Username";
    userEmail = user?.email ?? 'No email';
    photoUrl = user?.photoURL;
    emit(UpdateProfileFillDataState());
  }

  updateImage() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(UpdateProfileProgressState(true));
        await FirebaseStorageService.uploadImage(filePath: image.path);
        await UserStorageService.createData('image', image.path);
        emit(UpdateProfileProgressState(false));
        emit(UpdateProfilePhotoSuccessState(image));
      }
    } catch (e) {
      emit(UpdateProfileErrorState(e.toString()));
    }
  }

  updateUserData({name, email}) async {
    emit(UpdateProfileProgressState(true));
    try {
      await UserService.updateUserData(name: name, email: email);

      await UserStorageService.createData('name', name);
      await UserStorageService.createData('email', email);

      emit(UpdateProfileProgressState(false));

      emit(UpdateProfileSuccessState());
    } catch (e) {
      emit(UpdateProfileErrorState(e.toString()));
    }
  }
}
