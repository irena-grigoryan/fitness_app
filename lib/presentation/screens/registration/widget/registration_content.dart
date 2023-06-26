import 'package:fitness_app/presentation/constants/color_constants.dart';
import 'package:fitness_app/presentation/constants/path_constants.dart';
import 'package:fitness_app/presentation/constants/text_constants.dart';
import 'package:fitness_app/data/services/validation_service.dart';
import 'package:fitness_app/presentation/screens/registration/registration_cubit.dart';
import 'package:fitness_app/presentation/widgets/app_button.dart';
import 'package:fitness_app/presentation/widgets/app_loading.dart';
import 'package:fitness_app/presentation/widgets/app_textField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationContent extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  RegistrationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              _getMainData(context),
              BlocBuilder<RegistrationCubit, RegistrationState>(
                builder: (context, state) {
                  if (state is RegistrationLoadingState) {
                    if (state.isShow) {
                      return _getLoading();
                    }
                  } else if (state is RegistrationSuccessState ||
                      state is RegistrationErrorMessageState) {
                    return const SizedBox();
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMainData(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            _getTitle(),
            const SizedBox(height: 20),
            _getForm(context),
            const SizedBox(height: 40),
            _getRegistrationButton(context),
            const SizedBox(height: 40),
            _getHaveAccountText(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _getLoading() {
    return const AppLoading();
  }

  Widget _getTitle() {
    return Column(children: [
      SizedBox(width: 56, height: 56, child: Image.asset(PathConstants.user)),
      const SizedBox(
        height: 16,
      ),
      const Text(
        TextConstants.registration,
        style: TextStyle(
          color: ColorConstants.textBlack,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ]);
  }

  Widget _getForm(BuildContext context) {
    final cubit = BlocProvider.of<RegistrationCubit>(context);
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      buildWhen: (_, currState) => currState is RegistrationInvalidFieldsState,
      builder: (context, state) {
        return Column(
          children: [
            Form(
              key: _formKey,
              child: AppTextField(
                title: TextConstants.username,
                placeholder: TextConstants.userNamePlaceholder,
                controller: cubit.userNameController,
                textInputAction: TextInputAction.next,
                errorText: TextConstants.usernameErrorText,
                isError: state is RegistrationInvalidFieldsState
                    ? !ValidationService.isUsernameValid(
                        cubit.userNameController.text)
                    : false,
                onTextChanged: () {
                  cubit.onTextChanged();
                },
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
              title: TextConstants.email,
              placeholder: TextConstants.emailPlaceholder,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              controller: cubit.emailController,
              errorText: TextConstants.emailErrorText,
              isError: state is RegistrationInvalidFieldsState
                  ? !ValidationService.isEmailValid(cubit.emailController.text)
                  : false,
              onTextChanged: () {
                cubit.onTextChanged();
              },
            ),
            const SizedBox(height: 20),
            AppTextField(
              title: TextConstants.password,
              placeholder: TextConstants.passwordPlaceholder,
              obscureText: true,
              isError: state is RegistrationInvalidFieldsState
                  ? !ValidationService.isPasswordValid(
                      cubit.passwordController.text)
                  : false,
              textInputAction: TextInputAction.next,
              controller: cubit.passwordController,
              errorText: TextConstants.passwordErrorText,
              onTextChanged: () {
                cubit.onTextChanged();
              },
            ),
            const SizedBox(height: 20),
            AppTextField(
              title: TextConstants.confirmPassword,
              placeholder: TextConstants.confirmPasswordPlaceholder,
              obscureText: true,
              isError: state is RegistrationInvalidFieldsState
                  ? !ValidationService.isConfirmPasswordValid(
                      cubit.passwordController.text,
                      cubit.confirmPasswordController.text)
                  : false,
              controller: cubit.confirmPasswordController,
              errorText: TextConstants.confirmPasswordErrorText,
              onTextChanged: () {
                cubit.onTextChanged();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _getRegistrationButton(BuildContext context) {
    final cubit = BlocProvider.of<RegistrationCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<RegistrationCubit, RegistrationState>(
        builder: (context, state) {
          return AppButton(
            title: TextConstants.registration,
            isEnabled: state is RegistrationButtonEnableChangedState
                ? state.isEnabled
                : false,
            onTap: () {
              if (_formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                cubit.registration();
              }
            },
          );
        },
      ),
    );
  }

  Widget _getHaveAccountText(BuildContext context) {
    final cubit = BlocProvider.of<RegistrationCubit>(context);
    return RichText(
      text: TextSpan(
        text: TextConstants.alreadyHaveAccount,
        style: const TextStyle(
          color: ColorConstants.textBlack,
          fontSize: 18,
        ),
        children: [
          TextSpan(
            text: " ${TextConstants.login}",
            style: const TextStyle(
              color: ColorConstants.mainColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                cubit.nextLoginScreen();
              },
          ),
        ],
      ),
    );
  }
}
