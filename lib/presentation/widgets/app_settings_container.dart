import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class SettingsContainer extends StatelessWidget {
  final bool withArrow;
  final bool withIcon;
  final Widget child;
  final Color? color;
  final Color? arrowColor;
  final String? icon;
  final Function()? onTap;

  const SettingsContainer({
    Key? key,
    this.withArrow = false,
    this.withIcon = false,
    required this.child,
    this.onTap,
    this.color,
    this.icon,
    this.arrowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color ?? ColorConstants.white,
          boxShadow: [
            BoxShadow(
                color: ColorConstants.textBlack.withOpacity(0.12),
                blurRadius: 5.0,
                spreadRadius: 1.1)
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  if (icon != null) Image.asset(icon!),
                  if (icon != null) const SizedBox(width: 24),
                  Expanded(child: child),
                  if (withArrow)
                    const Icon(Icons.arrow_forward_ios,
                        color: ColorConstants.mainColor, size: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
