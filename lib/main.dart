import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_10y.dart' as tz;
import 'package:fitness_app/data/services/notification_service.dart';
import 'package:fitness_app/di/dependency_injections.dart' as di;
import 'package:fitness_app/presentation/screens/introduction/introduction_screen.dart';
import 'package:fitness_app/presentation/screens/login/login_screen.dart';
import 'package:fitness_app/presentation/screens/main/main_screen.dart';
import 'package:fitness_app/presentation/screens/notifications/notifications_screen.dart';
import 'package:fitness_app/presentation/screens/registration/registration_screen.dart';
import 'package:fitness_app/presentation/screens/reset_password/reset_password_screen.dart';
import 'package:fitness_app/presentation/screens/update_password/update_password_screen.dart';
import 'package:fitness_app/presentation/screens/update_profile/update_profile_screen.dart';
import 'package:fitness_app/presentation/screens/workout_steps/workout_steps_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      NotificationService.flutterLocalNotificationsPlugin;

  @override
  initState() {
    super.initState();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    tz.initializeTimeZones();

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: selectNotification);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final isLoggedIn = currentUser != null;
    return MaterialApp(
      title: 'Fitness App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
      ),
      initialRoute: '/',
      routes: {
        '/': isLoggedIn
            ? (context) => const MainScreen()
            : (context) => const IntroductionScreen(),
        RegistrationScreen.routeName: (context) => const RegistrationScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
        UpdateProfileScreen.routeName: (context) => const UpdateProfileScreen(),
        UpdatePasswordScreen.routeName: (context) =>
            const UpdatePasswordScreen(),
        NotificationsScreen.routeName: (context) => NotificationsScreen(),
        WorkoutStepsScreen.routeName: (context) => WorkoutStepsScreen(),
      },
    );
  }

  Future selectNotification(NotificationResponse? payload) async {
    showDialog(
      context: context,
      builder: (context) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }
}
