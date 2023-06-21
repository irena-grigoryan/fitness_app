import 'package:fitness_app/core/constants/path_constants.dart';
import 'package:fitness_app/core/constants/text_constants.dart';
import 'package:fitness_app/data/models/workouts/workouts_model.dart';
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

  static final List<Workout> topWorkouts = [
    Workout(
      title: TextConstants.aerobicTitle,
      exercises: TextConstants.aerobicExercises,
      minutes: TextConstants.aerobicMinutes,
      image: PathConstants.aerobic,
    ),
    Workout(
      title: TextConstants.strengthTitle,
      exercises: TextConstants.strengthExercises,
      minutes: TextConstants.strengthMinutes,
      image: PathConstants.strength,
    ),
  ];

  static final List<Workout> workouts = [
    Workout(
        id: '1',
        title: TextConstants.balanceTitle,
        exercises: TextConstants.balanceExercises,
        minutes: TextConstants.balanceMinutes,
        currentProgress: 0,
        progress: 3,
        image: PathConstants.balance,
        workoutDetailsList: [
          WorkoutDetailsData(
            id: 'exercise1',
            title: TextConstants.exercise1,
            minutes: TextConstants.exercise1Minutes,
            progress: 0,
            video: PathConstants.balanceVideo1,
            steps: [
              TextConstants.balanceStep1,
              TextConstants.balanceStep2,
              TextConstants.balanceStep3,
              TextConstants.balanceStep4,
              TextConstants.balanceStep5,
            ],
          ),
          WorkoutDetailsData(
            id: 'exercise2',
            title: TextConstants.exercise2,
            minutes: TextConstants.exercise2Minutes,
            progress: 0,
            video: PathConstants.balanceVideo2,
            steps: [
              TextConstants.balanceStep1,
              TextConstants.balanceStep2,
              TextConstants.balanceStep4,
              TextConstants.balanceStep5,
            ],
          ),
          WorkoutDetailsData(
            id: 'exercise3',
            title: TextConstants.exercise3,
            minutes: TextConstants.exercise3Minutes,
            progress: 0,
            video: PathConstants.balanceVideo3,
            steps: [
              TextConstants.balanceStep1,
              TextConstants.balanceStep2,
              TextConstants.balanceStep3,
              TextConstants.balanceStep5,
            ],
          ),
        ]),
    Workout(
        id: '2',
        title: TextConstants.enduranceTitle,
        exercises: TextConstants.enduranceExercises,
        minutes: TextConstants.enduranceMinutes,
        currentProgress: 0,
        progress: 3,
        image: PathConstants.endurance,
        workoutDetailsList: [
          WorkoutDetailsData(
            id: 'exercise1',
            title: TextConstants.exercise1,
            minutes: TextConstants.exercise1Minutes,
            video: PathConstants.enduranceVideo1,
            progress: 0,
            steps: [
              TextConstants.enduranceStep1,
              TextConstants.enduranceStep2,
              TextConstants.enduranceStep3,
              TextConstants.enduranceStep4,
              TextConstants.enduranceStep5,
            ],
          ),
          WorkoutDetailsData(
            id: 'exercise2',
            title: TextConstants.exercise2,
            minutes: TextConstants.exercise2Minutes,
            progress: 0,
            video: PathConstants.enduranceVideo2,
            steps: [
              TextConstants.enduranceStep1,
              TextConstants.enduranceStep2,
              TextConstants.enduranceStep3,
              TextConstants.enduranceStep5,
            ],
          ),
          WorkoutDetailsData(
            id: 'exercise3',
            title: TextConstants.exercise3,
            minutes: TextConstants.exercise3Minutes,
            progress: 0,
            video: PathConstants.enduranceVideo3,
            steps: [
              TextConstants.enduranceStep1,
              TextConstants.enduranceStep3,
              TextConstants.enduranceStep4,
              TextConstants.enduranceStep5,
            ],
          ),
        ]),
    Workout(
        id: '3',
        title: TextConstants.fullBodyTitle,
        exercises: TextConstants.fullBodyExercises,
        minutes: TextConstants.fullBodyMinutes,
        currentProgress: 0,
        progress: 3,
        image: PathConstants.fullBody,
        workoutDetailsList: [
          WorkoutDetailsData(
            id: 'exercise1',
            title: TextConstants.exercise1,
            minutes: TextConstants.exercise1Minutes,
            video: PathConstants.fullBodyVideo1,
            progress: 0,
            steps: [
              TextConstants.fullBodyStep1,
              TextConstants.fullBodyStep2,
              TextConstants.fullBodyStep3,
              TextConstants.fullBodyStep4,
              TextConstants.fullBodyStep5,
            ],
          ),
          WorkoutDetailsData(
            id: 'exercise2',
            title: TextConstants.exercise2,
            minutes: TextConstants.exercise2Minutes,
            progress: 0,
            video: PathConstants.fullBodyVideo2,
            steps: [
              TextConstants.fullBodyStep1,
              TextConstants.fullBodyStep2,
              TextConstants.fullBodyStep4,
              TextConstants.fullBodyStep5,
            ],
          ),
          WorkoutDetailsData(
            id: 'exercise3',
            title: TextConstants.exercise3,
            minutes: TextConstants.exercise3Minutes,
            video: PathConstants.fullBodyVideo3,
            progress: 0,
            steps: [
              TextConstants.fullBodyStep1,
              TextConstants.fullBodyStep3,
              TextConstants.fullBodyStep4,
              TextConstants.fullBodyStep5,
            ],
          ),
        ]),
    Workout(
        id: '4',
        title: TextConstants.flexibilityTitle,
        exercises: TextConstants.flexibilityExercises,
        minutes: TextConstants.flexibilityMinutes,
        currentProgress: 0,
        progress: 3,
        image: PathConstants.flexibility,
        workoutDetailsList: [
          WorkoutDetailsData(
            id: 'exercise1',
            title: TextConstants.exercise1,
            minutes: TextConstants.exercise1Minutes,
            progress: 0,
            video: PathConstants.flexibilityVideo1,
            steps: [
              TextConstants.flexibilityStep1,
              TextConstants.flexibilityStep2,
              TextConstants.flexibilityStep3,
              TextConstants.flexibilityStep4,
              TextConstants.flexibilityStep5,
            ],
          ),
          WorkoutDetailsData(
            id: 'exercise2',
            title: TextConstants.exercise2,
            minutes: TextConstants.exercise2Minutes,
            progress: 0,
            video: PathConstants.flexibilityVideo2,
            steps: [
              TextConstants.flexibilityStep1,
              TextConstants.flexibilityStep2,
              TextConstants.flexibilityStep4,
              TextConstants.flexibilityStep5,
            ],
          ),
          WorkoutDetailsData(
            id: 'exercise3',
            title: TextConstants.exercise3,
            minutes: TextConstants.exercise3Minutes,
            progress: 0,
            video: PathConstants.flexibilityVideo3,
            steps: [
              TextConstants.flexibilityStep1,
              TextConstants.flexibilityStep2,
              TextConstants.flexibilityStep4,
              TextConstants.flexibilityStep5,
            ],
          ),
        ]),
  ];
}
