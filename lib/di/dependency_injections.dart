import 'package:fitness_app/data/data_sources/auth_remote_data_source.dart';
import 'package:fitness_app/data/data_sources/http_manager.dart';
import 'package:fitness_app/data/data_sources/user_remote_data_source.dart';
import 'package:fitness_app/data/data_sources/user_local_data_source.dart';
import 'package:fitness_app/data/data_sources/workouts_local_data_source.dart';
import 'package:fitness_app/data/repositories/auth_repository_impl.dart';
import 'package:fitness_app/data/repositories/user_repository_impl.dart';
import 'package:fitness_app/data/repositories/workouts_repository_impl.dart';
import 'package:fitness_app/domain/repositories/auth_repository.dart';
import 'package:fitness_app/domain/repositories/user_repository.dart';
import 'package:fitness_app/domain/repositories/workouts_repository.dart';
import 'package:fitness_app/domain/use_cases/auth/create_user_use_case.dart';
import 'package:fitness_app/domain/use_cases/auth/deactivate_use_case.dart';
import 'package:fitness_app/domain/use_cases/auth/get_token_use_case.dart';
import 'package:fitness_app/domain/use_cases/auth/log_out_use_case.dart';
import 'package:fitness_app/domain/use_cases/auth/login_use_case.dart';
import 'package:fitness_app/domain/use_cases/auth/registration_use_case.dart';
import 'package:fitness_app/domain/use_cases/auth/reset_password_use_case.dart';
import 'package:fitness_app/domain/use_cases/user/get_user_data_use_case.dart';
import 'package:fitness_app/domain/use_cases/user/update_email_use_case.dart';
import 'package:fitness_app/domain/use_cases/user/update_password_use_case.dart';
import 'package:fitness_app/domain/use_cases/user/update_user_name_use_case.dart';
import 'package:fitness_app/domain/use_cases/user/update_photo_use_case.dart';
import 'package:fitness_app/domain/use_cases/workouts/get_workouts_use_case.dart';
import 'package:fitness_app/domain/use_cases/workouts/save_workouts_use_case.dart';
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
  // Data Source
  sl.registerSingleton<HttpManager>(HttpManagerImpl());
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl());
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<WorkoutsLocalDataSource>(
      () => WorkoutsLocalDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl(), sl()));
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<WorkoutsRepository>(
      () => WorkoutsRepositoryImpl(sl()));

  // Use cases
  sl.registerFactory(() => RegistrationUseCase(sl()));
  sl.registerFactory(() => LoginUseCase(sl()));
  sl.registerFactory(() => ResetPasswordUseCase(sl()));
  sl.registerFactory(() => GetTokenUseCase(sl()));
  sl.registerFactory(() => LogOutUseCase(sl()));
  sl.registerFactory(() => DeactivateUseCase(sl()));
  sl.registerFactory(() => UpdateEmailUseCase(sl()));
  sl.registerFactory(() => UpdateUserNameUseCase(sl()));
  sl.registerFactory(() => UpdatePhotoUseCase(sl()));
  sl.registerFactory(() => UpdatePasswordUseCase(sl()));
  sl.registerFactory(() => GetUserDataUseCase(sl()));
  sl.registerFactory(() => CreateUserUseCase(sl()));
  sl.registerFactory(() => SaveWorkoutsUseCase(sl()));
  sl.registerFactory(() => GetWorkoutsUseCase(sl()));

  //Cubit
  sl.registerFactory(() => IntroductionCubit());
  sl.registerFactory(() => RegistrationCubit(sl(), sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => ResetPasswordCubit(sl()));
  sl.registerFactory(() => MainCubit());
  sl.registerFactory(() => WorkoutsCubit(sl()));
  sl.registerFactory(() => HomeCubit(sl(), sl()));
  sl.registerFactory(() => SettingsCubit(sl(), sl(), sl()));
  sl.registerFactory(() => UpdateProfileCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => UpdatePasswordCubit(sl()));
  sl.registerFactory(() => NotificationsCubit());
  sl.registerFactory(() => WorkoutStepsCubit());
  sl.registerFactory(() => WorkoutStartCubit(sl()));
}
