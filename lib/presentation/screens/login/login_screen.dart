import 'package:fitness_app/presentation/screens/login/login_cubit.dart';
import 'package:fitness_app/presentation/screens/login/widget/login_content.dart';
import 'package:fitness_app/presentation/screens/main/main_screen.dart';
import 'package:fitness_app/presentation/screens/registration/registration_screen.dart';
import 'package:fitness_app/presentation/screens/reset_password/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/di/dependency_injections.dart' as di;

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => di.sl(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginNextResetPasswordScreenState) {
            Navigator.of(context).pushNamed(ResetPasswordScreen.routeName);
          } else if (state is LoginNextRegistrationScreenState) {
            Navigator.of(context)
                .pushReplacementNamed(RegistrationScreen.routeName);
          } else if (state is LoginNextMainScreenState) {
            Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return const LoginContent();
        },
      ),
    );
  }
}
