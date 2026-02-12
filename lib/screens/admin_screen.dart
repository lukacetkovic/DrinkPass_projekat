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
                  child: _clubsList(context),
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
    stream: FirebaseFirestore.instance.collection('users').limit(10).snapshots(),
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
            onEdit: () => _showRoleDialog(
              context,
              userId: doc.id,
              currentRole: role,
            ),
            onDelete: () => _confirmDelete(
              context,
              title: 'Delete user?',
              message: 'This will remove the user document from Firestore.',
              onConfirm: () => FirebaseFirestore.instance
                  .collection('users')
                  .doc(doc.id)
                  .delete(),
            ),
          );
        }).toList(),
      );
    },
  );
}

Widget _clubsList(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _smallActionButton(
        text: 'ADD EVENT',
        onTap: () => _showClubForm(context),
      ),
      const SizedBox(height: 12),
      StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('clubs').limit(10).snapshots(),
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
              onEdit: () => _showClubForm(
                context,
                docId: doc.id,
                data: data,
              ),
              onDelete: () => _confirmDelete(
                context,
                title: 'Delete event?',
                message: 'This will remove the event and its data.',
                onConfirm: () => FirebaseFirestore.instance
                    .collection('clubs')
                    .doc(doc.id)
                    .delete(),
              ),
            );
          }).toList(),
        );
      },
      ),
    ],
  );
}

Widget _reservationsList() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('reservations')
        .limit(10)
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
            onDelete: () => _confirmDelete(
              context,
              title: 'Cancel reservation?',
              message: 'This will delete the reservation.',
              onConfirm: () => FirebaseFirestore.instance
                  .collection('reservations')
                  .doc(doc.id)
                  .delete(),
            ),
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
  VoidCallback? onEdit,
  VoidCallback? onDelete,
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
        if (onEdit != null) ...[
          const SizedBox(width: 6),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit, color: Colors.white70, size: 18),
          ),
        ],
        if (onDelete != null) ...[
          const SizedBox(width: 4),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete, color: Colors.white70, size: 18),
          ),
        ],
      ],
    ),
  );
}

  Widget _smallActionButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          gradient: primaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF4D6D).withOpacity(0.5),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context, {
    required String title,
    required String message,
    required Future<void> Function() onConfirm,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 28),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2E2A8A),
                  Color(0xFF1A0F3D),
                  Color(0xFF120014),
                  Color(0xFF000000),
                ],
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.45),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white30),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text(
                            'NO',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: primaryGradient,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF4D6D).withOpacity(0.6),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text(
                            'YES',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    if (result == true) {
      await onConfirm();
    }
  }

  Future<void> _showRoleDialog(
    BuildContext context, {
    required String userId,
    required String currentRole,
  }) async {
    await showDialog<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 28),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2E2A8A),
                  Color(0xFF1A0F3D),
                  Color(0xFF120014),
                  Color(0xFF000000),
                ],
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.45),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Change role',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Current role: ${currentRole.toUpperCase()}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontFamily: 'Poppins',
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 18),
                _smallActionButton(
                  text: 'SET USER',
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .update({'role': 'user'});
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 10),
                _smallActionButton(
                  text: 'SET ADMIN',
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .update({'role': 'admin'});
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white30),
                    ),
                    child: const Center(
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showClubForm(
    BuildContext context, {
    String? docId,
    Map<String, dynamic>? data,
  }) async {
    final name = TextEditingController(text: data?['name'] ?? '');
    final homeSubtitle =
        TextEditingController(text: data?['homeSubtitle'] ?? '');
    final type = TextEditingController(text: data?['type'] ?? '');
    final ageLimit = TextEditingController(text: data?['ageLimit'] ?? '');
    final category =
        TextEditingController(text: data?['category'] ?? 'TOP_PICK');
    final date = TextEditingController(text: data?['date'] ?? '');
    final time = TextEditingController(text: data?['time'] ?? '');
    final phone = TextEditingController(text: data?['phone'] ?? '');
    final offer = TextEditingController(text: data?['offer'] ?? '');
    final description = TextEditingController(text: data?['description'] ?? '');
    final homeImage = TextEditingController(text: data?['homeImage'] ?? '');
    final detailsImage =
        TextEditingController(text: data?['detailsImage'] ?? '');
    final lat = TextEditingController(text: data?['lat']?.toString() ?? '');
    final lng = TextEditingController(text: data?['lng']?.toString() ?? '');

    await showDialog<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2E2A8A),
                  Color(0xFF1A0F3D),
                  Color(0xFF120014),
                  Color(0xFF000000),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    docId == null ? 'Add event' : 'Edit event',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _formSection(
                    'Basic info',
                    [
                      _field('Name', name),
                      _field('Performer (homeSubtitle)', homeSubtitle),
                      _field('Type', type),
                      _field('Age limit', ageLimit),
                      _field(
                        'Category (TOP_PICK / MOST_POPULAR / BEST_OFFERS)',
                        category,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _formSection(
                    'Schedule',
                    [
                      _field('Date', date),
                      _field('Time', time),
                      _field('Phone', phone),
                      _field('Offer', offer),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _formSection(
                    'Media',
                    [
                      _field('Home image path', homeImage),
                      _field('Details image path', detailsImage),
                      _field('Description', description, maxLines: 3),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _formSection(
                    'Location',
                    [
                      _field(
                        'Latitude',
                        lat,
                        keyboardType: TextInputType.number,
                      ),
                      _field(
                        'Longitude',
                        lng,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white30),
                              color: Colors.white.withOpacity(0.04),
                            ),
                            child: const Center(
                              child: Text(
                                'CANCEL',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final payload = <String, dynamic>{
                              'name': name.text.trim(),
                              'homeSubtitle': homeSubtitle.text.trim(),
                              'type': type.text.trim(),
                              'ageLimit': ageLimit.text.trim(),
                              'category': category.text.trim().toUpperCase(),
                              'date': date.text.trim(),
                              'time': time.text.trim(),
                              'phone': phone.text.trim(),
                              'offer': offer.text.trim(),
                              'description': description.text.trim(),
                              'homeImage': homeImage.text.trim(),
                              'detailsImage': detailsImage.text.trim(),
                            };
                            final latVal = double.tryParse(lat.text.trim());
                            final lngVal = double.tryParse(lng.text.trim());
                            if (latVal != null) payload['lat'] = latVal;
                            if (lngVal != null) payload['lng'] = lngVal;
                            payload.removeWhere(
                              (k, v) =>
                                  v == null ||
                                  (v is String && v.isEmpty),
                            );

                            if (docId == null) {
                              await FirebaseFirestore.instance
                                  .collection('clubs')
                                  .add(payload);
                            } else {
                              await FirebaseFirestore.instance
                                  .collection('clubs')
                                  .doc(docId)
                                  .update(payload);
                            }
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              gradient: primaryGradient,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFFFF4D6D).withOpacity(0.6),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'SAVE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.08),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _formSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}
