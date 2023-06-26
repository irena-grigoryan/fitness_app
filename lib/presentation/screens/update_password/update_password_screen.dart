import 'package:fitness_app/presentation/constants/color_constants.dart';
import 'package:fitness_app/presentation/constants/text_constants.dart';
import 'package:fitness_app/data/services/validation_service.dart';
import 'package:fitness_app/domain/entities/user_entity.dart';
import 'package:fitness_app/presentation/screens/update_password/update_password_cubit.dart';
import 'package:fitness_app/presentation/screens/update_profile/update_profile_cubit.dart';
import 'package:fitness_app/presentation/widgets/app_button.dart';
import 'package:fitness_app/presentation/widgets/app_loading.dart';
import 'package:fitness_app/presentation/widgets/app_settings_container.dart';
import 'package:fitness_app/presentation/widgets/settings_textField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/di/dependency_injections.dart' as di;

class UpdatePasswordScreen extends StatefulWidget {
  static const routeName = '/update_password';

  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool isNewPassInvalid = false;
  bool isConfirmPassInvalid = false;
  String? userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildContext(context),
        appBar: AppBar(
            title: Text(TextConstants.changePassword,
                style: TextStyle(color: Colors.black, fontSize: 18)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(
              color: ColorConstants.mainColor,
            )));
  }

  BlocProvider<UpdatePasswordCubit> _buildContext(BuildContext context) {
    return BlocProvider<UpdatePasswordCubit>(
      create: (context) => di.sl()..getUserData(),
      child: BlocConsumer<UpdatePasswordCubit, UpdatePasswordState>(
        builder: (context, state) {
          if (state is UpdatePasswordFillDataState) {
            fillUserData(state.user, context);
          } else if (state is UpdateProfileProgressState)
            return Stack(children: [_getMainContent(context), AppLoading()]);
          else if (state is UpdatePasswordErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            });
          } else if (state is UpdatePasswordSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
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
    final cubit = BlocProvider.of<UpdatePasswordCubit>(context);
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: SizedBox(
            height: height - 140 - MediaQuery.of(context).padding.bottom,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                  userName == null
                      ? ''
                      : '$userName, ${TextConstants.updatePassword}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  )),
              SizedBox(height: 40),
              Text(TextConstants.newPassword,
                  style: TextStyle(fontWeight: FontWeight.w600)),
              SettingsContainer(
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: SettingsTextField(
                    controller: _newPassController,
                    obscureText: true,
                    placeHolder: TextConstants.passwordPlaceholder,
                  ),
                ),
              ),
              if (isNewPassInvalid)
                Text(TextConstants.passwordErrorText,
                    style: TextStyle(color: ColorConstants.errorColor)),
              SizedBox(height: 10),
              Text(TextConstants.confirmPassword,
                  style: TextStyle(fontWeight: FontWeight.w600)),
              SettingsContainer(
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: SettingsTextField(
                    controller: _confirmPassController,
                    obscureText: true,
                    placeHolder: TextConstants.confirmPasswordPlaceholder,
                  ),
                ),
              ),
              if (isConfirmPassInvalid)
                Text(TextConstants.confirmPasswordErrorText,
                    style: TextStyle(color: ColorConstants.errorColor)),
              Spacer(),
              AppButton(
                title: TextConstants.save,
                isEnabled: true,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    isNewPassInvalid = !ValidationService.isPasswordValid(
                        _newPassController.text);
                    isConfirmPassInvalid =
                        _newPassController.text != _confirmPassController.text;
                  });
                  if (!(isNewPassInvalid || isConfirmPassInvalid)) {
                    cubit.updatePassword(_newPassController.text);
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  fillUserData(UserEntity user, BuildContext context) {
    userName = user.name;
  }
}
