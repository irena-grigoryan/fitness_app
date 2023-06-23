import 'package:fitness_app/presentation/constants/color_constants.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final VoidCallback onTap;
  final bool? fullSize;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
    required this.title,
    this.isEnabled = true,
    required this.onTap,
    this.fullSize = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullSize! ? double.infinity : width,
      height: fullSize! ? 55 : height,
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
