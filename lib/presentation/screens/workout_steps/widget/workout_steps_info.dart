import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class WorkoutStepsInfo extends StatelessWidget {
  final String icon;
  final String text;

  WorkoutStepsInfo({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorConstants.turquoise.withOpacity(0.12),
      ),
      child: Row(
        children: [
          Image.asset(icon, height: 17, width: 17, fit: BoxFit.fill),
          const SizedBox(width: 7),
          Text(text,
              style: TextStyle(
                  color: ColorConstants.turquoise,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
