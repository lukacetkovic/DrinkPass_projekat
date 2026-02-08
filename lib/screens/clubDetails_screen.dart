import 'package:flutter/material.dart';

class ClubDetailsScreen extends StatelessWidget {
  final bool isLoggedIn;

  const ClubDetailsScreen({super.key, this.isLoggedIn = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2B2FAE), Color(0xFF000000)],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _headerImage(context, isLoggedIn),
                    const SizedBox(height: 16),
                    SafeArea(
                      top: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _clubInfo(context, isLoggedIn),
                          const SizedBox(height: 24),
                          _mapSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _bottomNavBar(),
          ],
        ),
      ),
    );
  }
}

Widget _headerImage(BuildContext context, bool isLoggedIn) {
  return Stack(
    children: [
      Image.asset(
        'assets/images/PUPIN2.png',
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
            child: const Text(
              'JACK DANIELS + COLA x2 = 50 EUR',
              style: TextStyle(
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

Widget _clubInfo(BuildContext context, bool isLoggedIn) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isLoggedIn)
          Row(
            children: List.generate(
              5,
              (index) => const Icon(Icons.star, size: 16, color: Colors.amber),
            ),
          ),
        const SizedBox(height: 8),
        const Text(
          'PUPIN PUB',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            fontSize: 26,
          ),
        ),
        const SizedBox(height: 12),
        _infoBubble(
          'DJ club in the core center of Novi Sad, featuring \nthe best DJs in town. The hottest place in town!\nFeaturing the best DJs and drink promotions!',
        ),
        const SizedBox(height: 25),

        Wrap(
          spacing: 5,
          runSpacing: 10,
          children: [
            _tag('21+', Icons.cake),
            _tag('DJ Club', Icons.music_note),
            _tag('TOP PICK 🔥', Icons.local_fire_department, highlight: true),
            _tag('21:00h - 01:00h', Icons.timeline),
            _tag('15.02.2026.', Icons.event),
            _tag('066 266 166', Icons.phone),
          ],
        ),
        const SizedBox(height: 24),

        GestureDetector(
          onTap: () => _showConfirmReservationDialog(context),
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

Widget _mapSection() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/images/PUPIN_MAPA.png',
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget _bottomNavBar() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12, top: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Icon(Icons.home, color: Colors.orange, size: 28),
        Image.asset('assets/images/LOGO.png', height: 46),
        const Icon(Icons.person_outline, color: Colors.white, size: 28),
      ],
    ),
  );
}

void _showConfirmReservationDialog(BuildContext context) {
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
              colors: [Color(0xFF1F2A6D), Color(0xFF0E1028)],
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
                  children: const [
                    Text(
                      'PUPIN PUB',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Jack Daniels + Cola x2 = 50 EUR',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 12),
                    Divider(color: Colors.white24),
                    SizedBox(height: 12),
                    Text(
                      'DATE: 15.02.2026.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      'TIME: 21:00h - 01:00h',
                      style: TextStyle(
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
                        onPressed: () {
                          Navigator.pop(context);
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
        backgroundColor: const Color(0xFF1E1E3F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
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
