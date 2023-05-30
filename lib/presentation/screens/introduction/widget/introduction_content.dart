import 'package:flutter/material.dart';

class IntroductionTile extends StatelessWidget {
  final String? title;
  final String? description;
  final String? imagePath;

  const IntroductionTile({
    super.key,
    this.title,
    this.description,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 34),
          Expanded(
            child: Image.asset(
              imagePath!,
            ),
          ),
          const SizedBox(height: 65),
          Text(
            title!,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24.0,
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth / 100,
            ),
            child: Text(
              description!,
              style: const TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
