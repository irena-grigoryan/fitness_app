import 'package:fitness_app/screens/settings/settings_cubit.dart';
import 'package:fitness_app/screens/settings/widget/settings_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/di/dependency_injections.dart' as di;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>(
      create: (context) => di.sl(),
      child: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SettingsLogoutState ||
              state is SettingsDeactivateAccountState) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
        },
        builder: (context, state) {
          return const SettingsContent();
        },
      ),
    );
  }
}
