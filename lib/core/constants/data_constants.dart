import 'package:fitness_app/core/constants/path_constants.dart';
import 'package:fitness_app/core/constants/text_constants.dart';
import 'package:fitness_app/data/workouts_data.dart';

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

  // Notifications
  static List<String> days = [
    TextConstants.everyday,
    TextConstants.monday_friday,
    TextConstants.weekends,
    TextConstants.monday,
    TextConstants.tuesday,
    TextConstants.wednesday,
    TextConstants.thursday,
    TextConstants.friday,
    TextConstants.saturday,
    TextConstants.sunday,
  ];

  static final List<WorkoutData> homeWorkouts = [
    WorkoutData(
      title: TextConstants.aerobicTitle,
      exercises: TextConstants.aerobicExercises,
      minutes: TextConstants.aerobicMinutes,
      image: PathConstants.aerobic,
    ),
    WorkoutData(
      title: TextConstants.strengthTitle,
      exercises: TextConstants.strengthExercises,
      minutes: TextConstants.strengthMinutes,
      image: PathConstants.strength,
    ),
  ];
}
