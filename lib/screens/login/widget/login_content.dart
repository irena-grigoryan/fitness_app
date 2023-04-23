import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:fitness_app/core/constants/path_constants.dart';
import 'package:fitness_app/core/constants/text_constants.dart';
import 'package:fitness_app/core/services/validation_service.dart';
import 'package:fitness_app/screens/login/login_cubit.dart';
import 'package:fitness_app/widgets/app_button.dart';
import 'package:fitness_app/widgets/app_loading.dart';
import 'package:fitness_app/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({Key? key}) : super(key: key);

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
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                if (state is LoginLoadingState) {
                  return _getLoading();
                } else if (state is LoginErrorState ||
                    state is LoginNextMainScreenState) {
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
      child: SingleChildScrollView(
        child: SizedBox(
          height: height - 30 - MediaQuery.of(context).padding.bottom,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              _getHeader(),
              const Spacer(flex: 1),
              _getForm(context),
              const SizedBox(height: 20),
              _getForgotPasswordButton(context),
              const Spacer(flex: 2),
              _getLoginButton(context),
              const SizedBox(height: 40),
              _getDoNotHaveAccountText(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getLoading() {
    return const AppLoading();
  }

  Widget _getHeader() {
    return Column(
      children: [
        SizedBox(width: 56, height: 56, child: Image.asset(PathConstants.user)),
        const SizedBox(
          height: 16,
        ),
        const Center(
          child: Text(
            TextConstants.login,
            style: TextStyle(
              color: ColorConstants.textBlack,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _getForm(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              title: TextConstants.email,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              placeholder: TextConstants.emailPlaceholder,
              controller: cubit.emailController,
              errorText: TextConstants.emailErrorText,
              isError: state is LoginShowErrorState
                  ? !ValidationService.isEmailValid(cubit.emailController.text)
                  : false,
              onTextChanged: () {
                cubit.onTextChanged();
              },
            ),
            const SizedBox(height: 20),
            AppTextField(
              title: TextConstants.password,
              placeholder: TextConstants.passwordPlaceholderLogin,
              controller: cubit.passwordController,
              errorText: TextConstants.passwordErrorText,
              isError: state is LoginShowErrorState
                  ? !ValidationService.isPasswordValid(
                      cubit.passwordController.text)
                  : false,
              obscureText: true,
              onTextChanged: () {
                cubit.onTextChanged();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _getForgotPasswordButton(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 21),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              TextConstants.forgotPassword,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorConstants.mainColor,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        cubit.resetPassword();
      },
    );
  }

  Widget _getLoginButton(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return AppButton(
            title: TextConstants.login,
            isEnabled: state is LoginButtonEnableChangedState
                ? state.isEnabled
                : false,
            onTap: () {
              FocusScope.of(context).unfocus();
              cubit.login();
            },
          );
        },
      ),
    );
  }

  Widget _getDoNotHaveAccountText(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);
    return Center(
      child: RichText(
        text: TextSpan(
          text: TextConstants.doNotHaveAnAccount,
          style: const TextStyle(
            color: ColorConstants.textBlack,
            fontSize: 18,
          ),
          children: [
            TextSpan(
              text: " ${TextConstants.registration}",
              style: const TextStyle(
                color: ColorConstants.mainColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  cubit.nextRegistrationScreen();
                },
            ),
          ],
        ),
      ),
    );
  }
}
