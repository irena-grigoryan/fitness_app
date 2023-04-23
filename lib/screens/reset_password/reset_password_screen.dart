import 'package:fitness_app/core/constants/text_constants.dart';
import 'package:fitness_app/screens/reset_password/reset_password_cubit.dart';
import 'package:fitness_app/di/dependency_injections.dart' as di;
import 'package:fitness_app/screens/reset_password/widget/reset_password_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/reset_password';

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordCubit>(
      create: (context) => di.sl(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            resetPasswordLinkSended(context);
          } else if (state is ResetPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return const ResetPasswordContent();
        },
      ),
    );
  }

  Future<void> resetPasswordLinkSended(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(TextConstants.resetPasswordLinkWasSent),
        duration: Duration(seconds: 3)));
    await Future.delayed(const Duration(seconds: 3));
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
