import 'dart:io';

import 'package:fitness_app/presentation/constants/color_constants.dart';
import 'package:fitness_app/presentation/constants/path_constants.dart';
import 'package:fitness_app/presentation/constants/text_constants.dart';
import 'package:fitness_app/data/services/validation_service.dart';
import 'package:fitness_app/domain/entities/user_entity.dart';
import 'package:fitness_app/presentation/screens/update_profile/update_profile_cubit.dart';
import 'package:fitness_app/presentation/widgets/app_button.dart';
import 'package:fitness_app/presentation/widgets/app_dialogs.dart';
import 'package:fitness_app/presentation/widgets/app_loading.dart';
import 'package:fitness_app/presentation/widgets/app_settings_container.dart';
import 'package:fitness_app/presentation/widgets/settings_textField.dart';
import 'package:fitness_app/di/dependency_injections.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const routeName = '/update_profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool isNameInvalid = false;
  bool isEmailInvalid = false;
  String? photoUrl;
  late String userName;
  late String userEmail;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildContext(context),
        appBar: AppBar(
            title: const Text(TextConstants.updateProfile,
                style: TextStyle(color: Colors.black, fontSize: 18)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: const IconThemeData(
              color: ColorConstants.mainColor,
            )));
  }

  BlocProvider<UpdateProfileCubit> _buildContext(BuildContext context) {
    return BlocProvider<UpdateProfileCubit>(
      create: (context) => di.sl()..getUserData(),
      child: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
        builder: (context, state) {
          if (state is UpdateProfileFillDataState) {
            fillUserData(context, state.user);
          } else if (state is UpdateProfileProgressState) {
            if (state.isShow) {
              return Stack(
                children: [_getMainContent(context), _getLoading()],
              );
            }
          } else if (state is UpdateProfileErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              Dialogs.showOpenSettingsDialog(
                  context: context,
                  title: TextConstants.cameraPermission,
                  content: TextConstants.cameAccess,
                  onPressed: openAppSettings);
            });
          } else if (state is UpdateProfilePhotoSuccessState) {
            photoUrl = state.image.path;
          } else if (state is UpdateProfileSuccessState) {
            Future.delayed(Duration.zero, () {
              Dialogs.showInformDialog(
                  context: context,
                  content: TextConstants.successUpdate,
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/main');
                  });
            });
          } else if (state is UpdateProfileErrorFillDataState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Dialogs.showInformDialog(
                  context: context,
                  content: 'Please login again',
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/login');
                  });
            });
          } else {
            return Center(
                child: CupertinoActivityIndicator(
              radius: 17,
            ));
          }

          return _getMainContent(context);
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget _getMainContent(BuildContext context) {
    final cubit = BlocProvider.of<UpdateProfileCubit>(context);
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: SizedBox(
            height: height - 140 - MediaQuery.of(context).padding.bottom,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(child: _getImageWidget()),
              const SizedBox(height: 15),
              Center(
                child: AppButton(
                  fullSize: false,
                  height: 40,
                  width: 140,
                  title: TextConstants.updatePhoto,
                  onTap: () {
                    cubit.updateImage();
                  },
                ),
              ),
              SizedBox(height: 15),
              Text(
                TextConstants.name,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SettingsContainer(
                  icon: PathConstants.edit,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: SettingsTextField(
                      controller: _nameController,
                      placeHolder: TextConstants.userNamePlaceholder,
                    ),
                  )),
              if (isNameInvalid)
                Text(TextConstants.nameError,
                    style: TextStyle(color: ColorConstants.errorColor)),
              Text(TextConstants.email,
                  style: TextStyle(fontWeight: FontWeight.w600)),
              SettingsContainer(
                  icon: PathConstants.edit,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: SettingsTextField(
                      controller: _emailController,
                      placeHolder: TextConstants.emailPlaceholder,
                    ),
                  )),
              if (isEmailInvalid)
                Text(TextConstants.emailErrorText,
                    style: TextStyle(color: ColorConstants.errorColor)),
              const Divider(),
              SettingsContainer(
                  withArrow: true,
                  icon: PathConstants.password,
                  onTap: () {
                    Navigator.of(context).pushNamed('/update_password');
                  },
                  child: const Text(TextConstants.changePassword,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ))),
              const Spacer(),
              AppButton(
                title: TextConstants.save,
                isEnabled: true,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    isNameInvalid = !(_nameController.text.length > 1);
                    isEmailInvalid =
                        !ValidationService.isEmailValid(_emailController.text);
                  });
                  if (!(isNameInvalid || isEmailInvalid)) {
                    if (userName != _nameController.text ||
                        userEmail != _emailController.text ||
                        photoUrl != cubit.photoUrl) {
                      cubit.updateUserData(
                          name: _nameController.text,
                          email: _emailController.text);
                      userName = _nameController.text;
                      userEmail = _emailController.text;
                    } else {
                      Navigator.of(context).pop();
                    }
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _getImageWidget() {
    if (photoUrl != null) {
      if (photoUrl!.startsWith('https://')) {
        return CircleAvatar(
            backgroundColor: ColorConstants.white,
            radius: 60,
            child: ClipOval(
                child: FadeInImage.assetNetwork(
                    placeholder: PathConstants.profile,
                    image: photoUrl!,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 120)));
      } else {
        return CircleAvatar(
            backgroundColor: ColorConstants.white,
            backgroundImage: FileImage(File(photoUrl!)),
            radius: 60);
      }
    } else {
      return const CircleAvatar(
          backgroundColor: ColorConstants.white,
          backgroundImage: AssetImage(PathConstants.profile),
          radius: 60);
    }
  }

  fillUserData(BuildContext context, UserEntity user) {
    final cubit = BlocProvider.of<UpdateProfileCubit>(context);
    userName = user.name!;
    userEmail = user.email!;
    photoUrl = cubit.photoUrl;
    _nameController.text = userName;
    _emailController.text = userEmail;
  }

  Widget _getLoading() {
    return const AppLoading();
  }
}
