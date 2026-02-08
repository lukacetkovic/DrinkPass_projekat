import 'package:flutter/material.dart';
import 'navigation/app_routes.dart';

import 'screens/home_screen.dart';
import 'screens/clubDetails_screen.dart';
import 'screens/login_screen.dart';
import 'screens/createNewAcc_screen.dart';
import 'screens/myProfile_screen.dart';

void main() {
  runApp(const DrinkPassApp());
}

class DrinkPassApp extends StatelessWidget {
  const DrinkPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.clubDetails: (context) => const ClubDetailsScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.createAccount: (context) => const CreateNewAccScreen(),
        AppRoutes.profile: (context) => const MyProfileScreen(),
      },
    );
  }
}