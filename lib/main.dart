import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const DrinkPassApp());
}

class DrinkPassApp extends StatelessWidget {
  const DrinkPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}