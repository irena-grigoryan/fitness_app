import 'package:fitness_app/presentation/screens/login/login_screen.dart';
import 'package:fitness_app/presentation/screens/main/main_screen.dart';
import 'package:fitness_app/presentation/screens/registration/registration_cubit.dart';
import 'package:fitness_app/presentation/screens/registration/widget/registration_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/di/dependency_injections.dart' as di;

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registration';

  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationCubit>(
      create: (context) => di.sl(),
      child: BlocConsumer<RegistrationCubit, RegistrationState>(
        listener: (context, state) {
          if (state is RegistrationNextMainScreenState) {
            Navigator.of(context).pushNamed(MainScreen.routeName);
          } else if (state is RegistrationNextLoginPageState) {
            Navigator.of(context).pushNamed(LoginScreen.routeName);
          } else if (state is RegistrationErrorMessageState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return RegistrationContent();
        },
      ),
    );
  }
}
