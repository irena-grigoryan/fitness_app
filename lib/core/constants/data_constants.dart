import 'package:fitness_app/core/constants/path_constants.dart';
import 'package:fitness_app/core/constants/text_constants.dart';

import 'package:fitness_app/screens/introduction/widget/introduction_content.dart';

class DataConstants {
  // Introduction
  static final introductionText = [
    const IntroductionTile(
        title: TextConstants.introductionTitle1,
        description: TextConstants.introductionDescription1,
        imagePath: PathConstants.introduction1),
    const IntroductionTile(
      title: TextConstants.introductionTitle2,
      description: TextConstants.introductionDescription2,
      imagePath: PathConstants.introduction2,
    ),
    const IntroductionTile(
        title: TextConstants.introductionTitle3,
        description: TextConstants.introductionDescription3,
        imagePath: PathConstants.introduction3),
  ];
}
