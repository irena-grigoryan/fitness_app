import 'package:fitness_app/presentation/screens/home/home_cubit.dart';
import 'package:fitness_app/presentation/screens/introduction/introduction_cubit.dart';
import 'package:fitness_app/presentation/screens/login/login_cubit.dart';
import 'package:fitness_app/presentation/screens/main/main_cubit.dart';
import 'package:fitness_app/presentation/screens/notifications/notifications_cubit.dart';
import 'package:fitness_app/presentation/screens/registration/registration_cubit.dart';
import 'package:fitness_app/presentation/screens/reset_password/reset_password_cubit.dart';
import 'package:fitness_app/presentation/screens/settings/settings_cubit.dart';
import 'package:fitness_app/presentation/screens/update_password/update_password_cubit.dart';
import 'package:fitness_app/presentation/screens/update_profile/update_profile_cubit.dart';
import 'package:fitness_app/presentation/screens/workout_start/workout_start_cubit.dart';
import 'package:fitness_app/presentation/screens/workout_steps/workout_steps_cubit.dart';
import 'package:fitness_app/presentation/screens/workouts/workouts_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //Cubit
  sl.registerFactory(() => IntroductionCubit());
  sl.registerFactory(() => RegistrationCubit());
  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => ResetPasswordCubit());
  sl.registerFactory(() => MainCubit());
  sl.registerFactory(() => WorkoutsCubit());
  sl.registerFactory(() => HomeCubit());
  sl.registerFactory(() => SettingsCubit());
  sl.registerFactory(() => UpdateProfileCubit());
  sl.registerFactory(() => UpdatePasswordCubit());
  sl.registerFactory(() => NotificationsCubit());
  sl.registerFactory(() => WorkoutStepsCubit(sl()));
  sl.registerFactory(() => WorkoutStartCubit());
}
