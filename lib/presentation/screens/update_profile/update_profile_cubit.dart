import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:fitness_app/core/services/storage_service.dart';
// import 'package:fitness_app/core/services/user_storage_service.dart';
import 'package:fitness_app/domain/entities/user_entity.dart';
import 'package:fitness_app/domain/use_cases/user/get_user_data_use_case.dart';
import 'package:fitness_app/domain/use_cases/user/update_email_use_case.dart';
import 'package:fitness_app/domain/use_cases/user/update_photo_use_case.dart';
import 'package:fitness_app/domain/use_cases/user/update_user_name_use_case.dart';
// import 'package:fitness_app/domain/use_cases/profile/update_photo_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateEmailUseCase _updateEmailUseCase;
  UpdateUserNameUseCase _updateUserNameUseCase;
  GetUserDataUseCase _getUserDataUseCase;
  UpdatePhotoUseCase _updatePhotoUseCase;
  UpdateProfileCubit(this._updateEmailUseCase, this._updateUserNameUseCase,
      this._updatePhotoUseCase, this._getUserDataUseCase)
      : super(UpdateProfileInitialState());

  XFile? image;

  final User? user = FirebaseAuth.instance.currentUser;
  late String userName;
  late String userEmail;
  String? photoUrl;
  UserEntity? userData;

  getUserData() async {
    userData = await _getUserDataUseCase.call();
    // userName = user?.displayName ?? '';
    // userEmail = user?.email ?? '';
    photoUrl = user?.photoURL;
    emit(UpdateProfileFillDataState(userData!));
  }

  updateImage() async {
    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        // final photoMap = <String, String>{
        //   'photoUrl': image!.path,
        // };
        emit(UpdateProfileProgressState(true));

        // await _updatePhotoUseCase.call(params: photoMap);
        await uploadImage(filePath: image!.path);
        // await UserStorageService.createData('image', image!.path);
        emit(UpdateProfileProgressState(false));
        emit(UpdateProfilePhotoSuccessState(image!));

        return image;
      }
    } catch (e) {
      emit(UpdateProfileErrorState(e.toString()));
    }
  }

  updateUserData({name, email}) async {
    emit(UpdateProfileProgressState(true));

    final emailMap = <String, String>{
      'email': email,
    };
    final nameMap = <String, String>{
      'displayName': name,
    };
    try {
      await _updateEmailUseCase.call(params: emailMap);
      await _updateUserNameUseCase.call(params: nameMap);

      // await UserService.updateUserData(name: name, email: email);
      // await UserStorageService.createData('name', name);
      // await UserStorageService.createData('email', email);
      emit(UpdateProfileProgressState(false));

      emit(UpdateProfileSuccessState());
    } catch (e) {
      emit(UpdateProfileErrorState(e.toString()));
    }
  }

  Future<bool> uploadImage({required String filePath}) async {
    File file = File(filePath);
    try {
      // final User? user = FirebaseAuth.instance.currentUser;
      if (userData != null) {
        TaskSnapshot upload = await FirebaseStorage.instance
            .ref('user_logos/${userData!.id}.png')
            .putFile(file);
        String downloadUrl = await upload.ref.getDownloadURL();

        final photoMap = <String, String>{
          'photoUrl': downloadUrl,
        };
        await _updatePhotoUseCase.call(params: photoMap);

        // await UserService.updatePhoto(downloadUrl);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
