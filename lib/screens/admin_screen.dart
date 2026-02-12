import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/auth_state.dart';
import '../navigation/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF2E2A8A),
      Color(0xFF1A0F3D),
      Color(0xFF120014),
      Color(0xFF000000),
    ],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFF4D6D), Color(0xFFB5179E)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(gradient: backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: _avatarCircle('assets/images/NEW_ACC_AVATAR.png')),
                const SizedBox(height: 18),
                const Text(
                  'ADMIN PANEL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Manage users, clubs and reservations',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.12)),
                    ),
                    child: const Text(
                      'ADMIN ACCESS',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                _adminSection(
                  title: 'Users',
                  subtitle: 'View all accounts and roles',
                  icon: Icons.people_alt_outlined,
                  child: _usersList(),
                ),
                const SizedBox(height: 16),
                _adminSection(
                  title: 'Events',
                  subtitle: 'Create, edit or delete events',
                  icon: Icons.local_bar_outlined,
                  child: _clubsList(),
                ),
                const SizedBox(height: 16),
                _adminSection(
                  title: 'Reservations',
                  subtitle: 'See and manage all reservations',
                  icon: Icons.event_available_outlined,
                  child: _reservationsList(),
                ),
                const SizedBox(height: 24),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.12)),
                  ),
                  child: const Text(
                    'You’re in charge of the night,\nkeep everything smooth and updated.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                _primaryButton(
                  text: 'LOG OUT',
                  onTap: () {
                    context.read<AuthState>().logout();
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _adminSection({
  required String title,
  required String subtitle,
  required IconData icon,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.08),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: Colors.white.withOpacity(0.12)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.35),
          blurRadius: 18,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: primaryGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        child,
      ],
    ),
  );
}


  Widget _avatarCircle(String asset) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: primaryGradient,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF4D6D).withOpacity(0.35),
            blurRadius: 40,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      padding: const EdgeInsets.all(6),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF0E1028),
        ),
        child: Image.asset(
          asset,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _primaryButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            gradient: primaryGradient,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF4D6D).withOpacity(0.6),
                blurRadius: 30,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                fontSize: 16,
                letterSpacing: 0.7,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _usersList() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('users').limit(5).snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text(
          'Loading users...',
          style: TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
        );
      }
      if (snapshot.hasError) {
        return const Text(
          'Failed to load users',
          style: TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
        );
      }
      final docs = snapshot.data?.docs ?? [];
      if (docs.isEmpty) {
        return const Text(
          'No users yet',
          style: TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
        );
      }
      return Column(
        children: docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final name = (data['displayName'] ?? '').toString();
          final email = (data['email'] ?? '').toString();
          final role = (data['role'] ?? 'user').toString();
          return _listItem(
            title: name.isNotEmpty ? name : email,
            subtitle: email.isNotEmpty ? email : doc.id,
            trailing: role.toUpperCase(),
          );
        }).toList(),
      );
    },
  );
}

Widget _clubsList() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('clubs').limit(5).snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text(
          'Loading clubs...',
          style: TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
        );
      }
      if (snapshot.hasError) {
        return const Text(
          'Failed to load clubs',
          style: TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
        );
      }
      final docs = snapshot.data?.docs ?? [];
      if (docs.isEmpty) {
        return const Text(
          'No clubs yet',
          style: TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
        );
      }
        return Column(
          children: docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final name = (data['name'] ?? '').toString();
            final category = (data['category'] ?? '').toString();
            final performer = (data['homeSubtitle'] ?? '').toString();
            final type = (data['type'] ?? '').toString();
            final date = (data['date'] ?? '').toString();
            final baseSubtitle = performer.isNotEmpty ? performer : type;
            final subtitle = baseSubtitle.isNotEmpty
                ? (date.isNotEmpty ? '$baseSubtitle • $date' : baseSubtitle)
                : (date.isNotEmpty ? date : 'Club');
            return _listItem(
              title: name.isNotEmpty ? name : doc.id,
              subtitle: subtitle,
              trailing: category.isNotEmpty ? category : 'CATEGORY',
            );
          }).toList(),
        );
      },
    );
  }

Widget _reservationsList() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('reservations')
        .limit(5)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text(
          'Loading reservations...',
          style: TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
        );
      }
      if (snapshot.hasError) {
        return const Text(
          'Failed to load reservations',
          style: TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
        );
      }
      final docs = snapshot.data?.docs ?? [];
      if (docs.isEmpty) {
        return const Text(
          'No reservations yet',
          style: TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
        );
      }
      return Column(
        children: docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final clubName = (data['clubName'] ?? '').toString();
          final performer =
              (data['homeSubtitle'] ?? data['performer'] ?? '').toString();
          final date = (data['date'] ?? '').toString();
          final email = (data['userEmail'] ?? '').toString();
          final subtitle = performer.isNotEmpty
              ? (date.isNotEmpty ? '$performer - $date' : performer)
              : (date.isNotEmpty ? date : 'Event');
          return _listItem(
            title: clubName.isNotEmpty ? clubName : 'Reservation',
            subtitle: subtitle,
            trailing: email.isNotEmpty ? email : 'USER',
          );
        }).toList(),
      );
    },
  );
}

Widget _listItem({
  required String title,
  required String subtitle,
  required String trailing,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.06),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white.withOpacity(0.1)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontFamily: 'Poppins',
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text(
          trailing,
          style: const TextStyle(
            color: Colors.white60,
            fontFamily: 'Poppins',
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
      ],
    ),
  );
}

}
