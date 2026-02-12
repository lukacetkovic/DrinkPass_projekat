import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../navigation/app_routes.dart';
import '../state/auth_state.dart';

class ClubDetailsScreen extends StatelessWidget {
  final bool isLoggedIn;

  const ClubDetailsScreen({super.key, this.isLoggedIn = true});

  @override
  Widget build(BuildContext context) {
    final clubId =
        ModalRoute.of(context)?.settings.arguments as String?;
    if (clubId == null || clubId.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Missing club id',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2E2A8A),
              Color(0xFF1A0F3D),
              Color(0xFF120014),
              Color(0xFF000000),
            ],
          ),
        ),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('clubs')
              .doc(clubId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return const Center(
                child: Text(
                  'Failed to load club',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            final data =
                snapshot.data!.data() as Map<String, dynamic>? ?? {};

            final name = data['name'] ?? '';
            final description = data['description'] ?? '';
            final detailsImage =
                data['detailsImage'] ?? data['homeImage'] ?? '';
            final offer = data['offer'] ?? '';
            final ageLimit = data['ageLimit'] ?? '';
            final type = data['type'] ?? '';
            final category = data['category'] ?? '';
            final time = data['time'] ?? '';
            final date = data['date'] ?? '';
            final phone = data['phone'] ?? '';
            final rating = (data['rating'] ?? 0).toInt();
            final lat = data['lat'];
            final lng = data['lng'];

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _headerImage(
                          context,
                          isLoggedIn,
                          detailsImage,
                          offer,
                        ),
                        const SizedBox(height: 16),
                        SafeArea(
                          top: false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _clubInfo(
                                context,
                                isLoggedIn,
                                clubId,
                                name,
                                description,
                                rating,
                                ageLimit,
                                type,
                                category,
                                time,
                                date,
                                phone,
                                offer,
                              ),
                              const SizedBox(height: 24),
                              _mapSection(lat: lat, lng: lng),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _glassBottomNav(context),
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget _headerImage(
  BuildContext context,
  bool isLoggedIn,
  String imagePath,
  String offer,
) {
  return Stack(
    children: [
      Image.asset(
        imagePath.isNotEmpty ? imagePath : 'assets/images/LOGO.png',
        height: 240,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      Positioned(
        top: MediaQuery.of(context).padding.top + 8,
        left: 12,
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      if (isLoggedIn)
        Positioned(
          bottom: 12,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF4D6D), Color(0xFFB5179E)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF4D6D).withOpacity(0.6),
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(0, 0),
                ),
                BoxShadow(
                  color: const Color(0xFFB5179E).withOpacity(0.45),
                  blurRadius: 30,
                  spreadRadius: 0,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Text(
              offer,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ),
    ],
  );
}

Widget _clubInfo(
  BuildContext context,
  bool isLoggedIn,
  String clubId,
  String name,
  String description,
  int rating,
  String ageLimit,
  String type,
  String category,
  String time,
  String date,
  String phone,
  String offer,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isLoggedIn)
          Row(
            children: List.generate(
              rating == 0 ? 5 : rating.clamp(1, 5),
              (index) => const Icon(Icons.star, size: 16, color: Colors.amber),
            ),
          ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            fontSize: 26,
          ),
        ),
        const SizedBox(height: 12),
        _infoBubble(description),
        const SizedBox(height: 25),

        Wrap(
          spacing: 5,
          runSpacing: 10,
          children: [
            if (ageLimit.isNotEmpty) _tag(ageLimit, Icons.cake),
            if (type.isNotEmpty) _tag(type, Icons.music_note),
            if (category.isNotEmpty)
              _tag('$category 🔥', Icons.local_fire_department, highlight: true),
            if (time.isNotEmpty) _tag(time, Icons.timeline),
            if (date.isNotEmpty) _tag(date, Icons.event),
            if (phone.isNotEmpty) _tag(phone, Icons.phone),
          ],
        ),
        const SizedBox(height: 24),

        GestureDetector(
          onTap: () => _showConfirmReservationDialog(
            context,
            clubId: clubId,
            clubName: name,
            offer: offer,
            date: date,
            time: time,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF4D6D), Color(0xFFB5179E)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF4D6D).withOpacity(0.6),
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(0, 0),
                ),
                BoxShadow(
                  color: const Color(0xFFB5179E).withOpacity(0.45),
                  blurRadius: 30,
                  spreadRadius: 0,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'RESERVE NOW!',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _infoBubble(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
        fontFamily: 'Poppins',
        fontSize: 13,
      ),
    ),
  );
}

Widget _tag(String text, IconData icon, {bool highlight = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      gradient: highlight
          ? const LinearGradient(
              colors: [Color(0xFFFF4D6D), Color(0xFFB5179E)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )
          : null,
      color: highlight ? null : Colors.white.withOpacity(0.12),
      borderRadius: BorderRadius.circular(16),
      boxShadow: highlight
          ? [
              BoxShadow(
                color: const Color(0xFFFF4D6D).withOpacity(0.6),
                blurRadius: 20,
                spreadRadius: 0,
                offset: const Offset(0, 0),
              ),
              BoxShadow(
                color: const Color(0xFFB5179E).withOpacity(0.45),
                blurRadius: 30,
                spreadRadius: 0,
                offset: const Offset(0, 0),
              ),
            ]
          : [],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.white),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _mapSection({dynamic lat, dynamic lng}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 220,
        width: double.infinity,
        color: Colors.white.withOpacity(0.08),
        child: Center(
          child: Text(
            lat != null && lng != null
                ? 'Map: $lat, $lng'
                : 'Map: location not set',
            style: const TextStyle(
              color: Colors.white70,
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ),
      ),
    ),
  );
}

const LinearGradient primaryGradient = LinearGradient(
  colors: [Color(0xFFFF4D6D), Color(0xFFB5179E)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

Widget _glassBottomNav(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Dodajemo da HOME dugme ima neku fuknciju - to jest da samo ide opet na HOME PAGE
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.home, color: Colors.white),
            ),
          ),

          // Dodajemo da LOGO isto ima neku fukcniju, i on da vraca na HOME 
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            },
            child: Image.asset('assets/images/LOGO.png', height: 42),
          ),

          // Dodajemo da MY PROFILE vraca na MY PROFILE screen 
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.profile);
            },
            child: const Icon(Icons.person_outline, color: Colors.white),
          ),
        ],
      ),
    );
  }

Future<void> _createReservation(
  BuildContext context, {
  required String clubId,
  required String clubName,
  required String offer,
  required String date,
  required String time,
}) async {
  final user = context.read<AuthState>().user;
  if (user == null) {
    _showSimpleError(context, 'You must be logged in to reserve.');
    return;
  }

  await FirebaseFirestore.instance.collection('reservations').add({
    'userId': user.uid,
    'clubId': clubId,
    'clubName': clubName,
    'offer': offer,
    'date': date,
    'time': time,
    'status': 'CONFIRMED',
    'createdAt': FieldValue.serverTimestamp(),
  });
}

void _showSimpleError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    ),
  );
}

void _showConfirmReservationDialog(
  BuildContext context, {
  required String clubId,
  required String clubName,
  required String offer,
  required String date,
  required String time,
}) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.6),
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF2E2A8A),
                Color(0xFF1A0F3D),
                Color(0xFF120014),
                Color(0xFF000000),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Confirm your reservation',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    Text(
                      clubName.isEmpty ? 'CLUB' : clubName,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      offer.isEmpty ? 'Offer' : offer,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: Colors.white24),
                    const SizedBox(height: 12),
                    Text(
                      'DATE: ${date.isEmpty ? '-' : date}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      'TIME: ${time.isEmpty ? '-' : time}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white30),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
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

                  const SizedBox(width: 12),

                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF4D6D), Color(0xFFB5179E)],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pinkAccent.withOpacity(0.5),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await _createReservation(
                            context,
                            clubId: clubId,
                            clubName: clubName,
                            offer: offer,
                            date: date,
                            time: time,
                          );
                          _showSuccessDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'CONFIRM',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 1,
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
}

void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF2E2A8A),
                Color(0xFF1A0F3D),
                Color(0xFF120014),
                Color(0xFF000000),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00F5A0), Color(0xFF00C9A7)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.5),
                      blurRadius: 24,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 36),
              ),

              const SizedBox(height: 20),

              const Text(
                'Reservation successful!',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 2),

              const Text(
                'Your spot has been secured. Enjoy!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, AppRoutes.profile);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF4D6D), Color(0xFFB5179E)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF4D6D).withOpacity(0.5),
                          blurRadius: 24,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'VIEW MY RESERVATIONS',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.25),
                      width: 1.2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'DONE',
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        letterSpacing: 1,
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
