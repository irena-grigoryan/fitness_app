import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final VoidCallback onTap;

  const AppButton({
    super.key,
    required this.title,
    this.isEnabled = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        gradient: isEnabled
            ? const LinearGradient(
                colors: [ColorConstants.orange, ColorConstants.mainColor])
            : const LinearGradient(colors: [
                ColorConstants.disabledColor,
                ColorConstants.disabledColor
              ]),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: onTap,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: ColorConstants.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
