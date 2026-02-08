import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/auth_state.dart';
import '../navigation/app_routes.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

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
                    ? _loggedInContent(context)
                    : _loggedOutContent(context),
              ),
              _bottomNavBar(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _loggedInContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/NEW_ACC_AVATAR.png', height: 180),
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

        const SizedBox(height: 32),

        SizedBox(
          width: 220,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              context.read<AuthState>().logout();
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
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
        Image.asset('assets/images/AVATAR3.png', height: 200),
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
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
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
      ],
    );
  }

  Widget _bottomNavBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Icon(Icons.home, color: Colors.white, size: 28),
          Icon(Icons.local_bar, color: Colors.white, size: 28),
          Icon(Icons.person, color: Colors.orange, size: 28),
        ],
      ),
    );
  }
}