import 'package:flutter/material.dart';
import 'home_screen.dart';

class MyProfileScreen extends StatelessWidget {
  final bool isLoggedIn;

  const MyProfileScreen({
    super.key,
    this.isLoggedIn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2B2FAE),
              Color(0xFF000000),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: isLoggedIn
                    ? _loggedInContent()
                    : _loggedOutContent(context),
              ),
              _bottomNavBar(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _loggedInContent() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 24),

      Image.asset(
        'assets/images/NEW_ACC_AVATAR.png',
        height: 180,
      ),

      const SizedBox(height: 24),

      const Text(
        'Welcome back 👋',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
      ),

      const SizedBox(height: 8),

      const Text(
        'user@email.com',
        style: TextStyle(
          color: Colors.white70,
          fontFamily: 'Poppins',
          fontSize: 14,
        ),
      ),

      const SizedBox(height: 20),

      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'You have access to all premium features',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      const SizedBox(height: 40),

      SizedBox(
        width: 220,
        height: 52,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF4D6D),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
          ),
          child: const Text(
            'LOG OUT',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _loggedOutContent(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        'assets/images/AVATAR3.png',
        height: 200,
      ),

      const SizedBox(height: 24),

      const Text(
        'You are not logged in',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
          fontSize: 26,
          fontWeight: FontWeight.w800,
        ),
      ),

      const SizedBox(height: 12),

      const Text(
        'Log in to unlock offers, ratings\nand personalized experience.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white70,
          fontFamily: 'Poppins',
          fontSize: 14,
        ),
      ),

      const SizedBox(height: 32),

      SizedBox(
        width: 260,
        height: 56,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF4D6D),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: const Text(
            'LOGIN',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ),
      ),

      const SizedBox(height: 20),

      GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeScreen(isLoggedIn: false),
            ),
          );
        },
        child: const Text(
          'Continue as guest',
          style: TextStyle(
            color: Colors.white70,
            fontFamily: 'Poppins',
            fontSize: 14,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ],
  );
}

Widget _bottomNavBar() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12, top: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Icon(Icons.home, color: Colors.white, size: 28),
        Image.asset(
          'assets/images/LOGO.png',
          height: 46,
        ),
        const Icon(Icons.person, color: Colors.orange, size: 28),
      ],
    ),
  );
}