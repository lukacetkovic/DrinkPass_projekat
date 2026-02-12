import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'navigation/app_routes.dart';
import 'state/auth_state.dart';

import 'screens/home_screen.dart';
import 'screens/clubDetails_screen.dart';
import 'screens/login_screen.dart';
import 'screens/createNewAcc_screen.dart';
import 'screens/myProfile_screen.dart';
import 'screens/auth_gate.dart';
import 'screens/admin_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthState(),
      child: const DrinkPassApp(),
    ),
  );
}

class DrinkPassApp extends StatelessWidget {
  const DrinkPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.authGate,
      routes: {
        AppRoutes.authGate: (context) => const AuthGate(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.clubDetails: (context) => const ClubDetailsScreen(),

        AppRoutes.login: (context) => LoginScreen(),
        AppRoutes.createAccount: (context) => CreateNewAccScreen(),

        AppRoutes.profile: (context) => const MyProfileScreen(),
        AppRoutes.admin: (context) => const AdminScreen(),
      },
    );
  }
}
