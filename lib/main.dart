import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/screens/introduction/introduction_screen.dart';
import 'package:fitness_app/screens/login/login_screen.dart';
import 'package:fitness_app/screens/main/main_screen.dart';
import 'package:fitness_app/screens/registration/registration_screen.dart';
import 'package:fitness_app/screens/reset_password/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/di/dependency_injections.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroductionScreen(),
        // '/': isLoggedIn
        //     ? (context) => const MainScreen()
        //     : (context) => const IntroductionScreen(),
        RegistrationScreen.routeName: (context) => const RegistrationScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
      },
    );
  }
}
