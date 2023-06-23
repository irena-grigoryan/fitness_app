import 'package:fitness_app/presentation/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ColorConstants.loading,
      child: Center(
        child: Theme(
          data: ThemeData(
            cupertinoOverrideTheme:
                const CupertinoThemeData(brightness: Brightness.dark),
          ),
          child: const CupertinoActivityIndicator(
            radius: 17,
          ),
        ),
      ),
    );
  }
}
