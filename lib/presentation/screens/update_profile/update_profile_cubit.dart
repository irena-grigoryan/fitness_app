import 'dart:io';

import 'package:equatable/equatable.dart';
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
  String? photoUrl;
  UserEntity? userData;

  getUserData() async {
    try {
      userData = await _getUserDataUseCase.call();
      photoUrl = userData?.photo;
      emit(UpdateProfileFillDataState(userData!));
    } catch (e) {
      emit(UpdateProfileErrorFillDataState());
    }
  }

  updateImage() async {
    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(UpdateProfileProgressState(true));

        await uploadImage(filePath: image!.path);

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

      emit(UpdateProfileProgressState(false));

      emit(UpdateProfileSuccessState());
    } catch (e) {
      emit(UpdateProfileErrorState(e.toString()));
    }
  }

  Future<bool> uploadImage({required String filePath}) async {
    File file = File(filePath);
    try {
      if (userData != null) {
        TaskSnapshot upload = await FirebaseStorage.instance
            .ref('user_logos/${userData!.id}.png')
            .putFile(file);
        String downloadUrl = await upload.ref.getDownloadURL();

        final photoMap = <String, String>{
          'photoUrl': downloadUrl,
        };
        await _updatePhotoUseCase.call(params: photoMap);

        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
