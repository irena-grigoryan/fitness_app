import 'package:fitness_app/core/constants/path_constants.dart';
import 'package:fitness_app/core/constants/text_constants.dart';
import 'package:fitness_app/data/workouts_data.dart';
import 'package:fitness_app/data/workouts_details_data.dart';

import 'package:fitness_app/presentation/screens/introduction/widget/introduction_content.dart';

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

  static final List<WorkoutData> topWorkouts = [
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

  static final List<WorkoutData> workouts = [
    WorkoutData(
        id: '1',
        title: TextConstants.balanceTitle,
        exercises: TextConstants.balanceExercises,
        minutes: TextConstants.balanceMinutes,
        currentProgress: 0,
        progress: 15,
        image: PathConstants.balance,
        workoutDetailsList: [
          WorkoutDetailsData(
            id: 'exercise1',
            title: TextConstants.exercise1,
            minutes: TextConstants.exercise1Minutes,
            progress: 0,
          ),
          WorkoutDetailsData(
            id: 'exercise2',
            title: TextConstants.exercise2,
            minutes: TextConstants.exercise2Minutes,
            progress: 0,
          ),
          WorkoutDetailsData(
            id: 'exercise3',
            title: TextConstants.exercise3,
            minutes: TextConstants.exercise3Minutes,
            progress: 0,
          ),
        ]),
    WorkoutData(
        id: '2',
        title: TextConstants.enduranceTitle,
        exercises: TextConstants.enduranceExercises,
        minutes: TextConstants.enduranceMinutes,
        currentProgress: 0,
        progress: 18,
        image: PathConstants.endurance,
        workoutDetailsList: [
          WorkoutDetailsData(
            id: 'exercise1',
            title: TextConstants.exercise1,
            minutes: TextConstants.exercise1Minutes,
            progress: 0,
          ),
          WorkoutDetailsData(
            id: 'exercise2',
            title: TextConstants.exercise2,
            minutes: TextConstants.exercise2Minutes,
            progress: 0,
          ),
          WorkoutDetailsData(
            id: 'exercise3',
            title: TextConstants.exercise3,
            minutes: TextConstants.exercise3Minutes,
            progress: 0,
          ),
        ]),
    WorkoutData(
        id: '3',
        title: TextConstants.fullBodyTitle,
        exercises: TextConstants.fullBodyExercises,
        minutes: TextConstants.fullBodyMinutes,
        currentProgress: 0,
        progress: 12,
        image: PathConstants.fullBody,
        workoutDetailsList: [
          WorkoutDetailsData(
            id: 'exercise1',
            title: TextConstants.exercise1,
            minutes: TextConstants.exercise1Minutes,
            progress: 0,
          ),
          WorkoutDetailsData(
            id: 'exercise2',
            title: TextConstants.exercise2,
            minutes: TextConstants.exercise2Minutes,
            progress: 0,
          ),
          WorkoutDetailsData(
            id: 'exercise3',
            title: TextConstants.exercise3,
            minutes: TextConstants.exercise3Minutes,
            progress: 0,
          ),
        ]),
    WorkoutData(
        id: '4',
        title: TextConstants.flexibilityTitle,
        exercises: TextConstants.flexibilityExercises,
        minutes: TextConstants.flexibilityMinutes,
        currentProgress: 0,
        progress: 8,
        image: PathConstants.flexibility,
        workoutDetailsList: [
          WorkoutDetailsData(
            id: 'exercise1',
            title: TextConstants.exercise1,
            minutes: TextConstants.exercise1Minutes,
            progress: 0,
          ),
          WorkoutDetailsData(
            id: 'exercise2',
            title: TextConstants.exercise2,
            minutes: TextConstants.exercise2Minutes,
            progress: 0,
          ),
          WorkoutDetailsData(
            id: 'exercise3',
            title: TextConstants.exercise3,
            minutes: TextConstants.exercise3Minutes,
            progress: 0,
          ),
        ]),
  ];
}
