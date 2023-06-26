import 'package:fitness_app/presentation/constants/color_constants.dart';
import 'package:fitness_app/presentation/constants/path_constants.dart';
import 'package:fitness_app/presentation/constants/text_constants.dart';
import 'package:fitness_app/data/services/validation_service.dart';
import 'package:fitness_app/presentation/screens/reset_password/reset_password_cubit.dart';
import 'package:fitness_app/presentation/widgets/app_button.dart';
import 'package:fitness_app/presentation/widgets/app_loading.dart';
import 'package:fitness_app/presentation/widgets/app_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordContent extends StatefulWidget {
  const ResetPasswordContent({Key? key}) : super(key: key);

  @override
  _ResetPasswordContentState createState() => _ResetPasswordContentState();
}

class _ResetPasswordContentState extends State<ResetPasswordContent> {
  bool _isButtonEnabled = false;
  bool _isTextFieldError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorConstants.white,
        child: Stack(
          children: [
            _getMainData(context),
            BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
              builder: (context, state) {
                if (state is ResetPasswordLoading) {
                  return _getLoading();
                } else if (state is ResetPasswordSuccess) {
                  return const SizedBox();
                } else if (state is ResetPasswordError) {
                  return const SizedBox();
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMainData(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: SizedBox(
          height: height -
              30 -
              MediaQuery.of(context).padding.bottom -
              kToolbarHeight,
          child: Column(
            children: [
              const SizedBox(height: 50),
              _getHeader(context),
              const Spacer(flex: 1),
              _getForm(context),
              const Spacer(flex: 2),
              _getResetPasswordButton(context),
              const SizedBox(height: 30),
              _getBackButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    return Column(children: [
      SizedBox(width: 56, height: 56, child: Image.asset(PathConstants.user)),
      const SizedBox(
        height: 16,
      ),
      const Text(
        TextConstants.resetPassword,
        style: TextStyle(
          color: ColorConstants.textBlack,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      )
    ]);
  }

  Widget _getLoading() {
    return const AppLoading();
  }

  Widget _getForm(BuildContext context) {
    final cubit = BlocProvider.of<ResetPasswordCubit>(context);
    return AppTextField(
      title: TextConstants.email,
      keyboardType: TextInputType.emailAddress,
      placeholder: TextConstants.emailPlaceholder,
      controller: cubit.emailController,
      errorText: TextConstants.emailErrorText,
      isError: _isTextFieldError,
      onTextChanged: () {
        setState(() {
          _isButtonEnabled = cubit.emailController.text.isNotEmpty;
        });
      },
    );
  }

  Widget _getResetPasswordButton(BuildContext context) {
    final cubit = BlocProvider.of<ResetPasswordCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppButton(
        title: TextConstants.sendActivationBuild,
        isEnabled: _isButtonEnabled,
        onTap: () {
          FocusScope.of(context).unfocus();
          if (_isButtonEnabled) {
            setState(() {
              _isTextFieldError =
                  !ValidationService.isEmailValid(cubit.emailController.text);
            });
            if (!_isTextFieldError) {
              cubit.resetPassword();
            }
          }
        },
      ),
    );
  }

  Widget _getBackButton(BuildContext context) {
    return GestureDetector(
      child: const Padding(
        padding: EdgeInsets.only(right: 21),
        child: Text(
          TextConstants.returnBack,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorConstants.mainColor,
          ),
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
      },
    );
  }
}
