import 'package:fitness_app/screens/home/home_cubit.dart';
import 'package:fitness_app/screens/introduction/introduction_cubit.dart';
import 'package:fitness_app/screens/login/login_cubit.dart';
import 'package:fitness_app/screens/main/main_cubit.dart';
import 'package:fitness_app/screens/registration/registration_cubit.dart';
import 'package:fitness_app/screens/reset_password/reset_password_cubit.dart';
import 'package:fitness_app/screens/settings/settings_cubit.dart';
import 'package:fitness_app/screens/workouts/workouts_cubit.dart';
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
}
