import 'package:flutter/material.dart';

class ClubDetailsScreen extends StatelessWidget {
  final bool isLoggedIn;

  const ClubDetailsScreen({
    super.key,
    this.isLoggedIn = true,
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
                          _clubInfo(isLoggedIn),
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
              color: Colors.black.withOpacity(0.65),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'JACK DANIELS + COLA x2',
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

Widget _clubInfo(bool isLoggedIn) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isLoggedIn)
          Row(
            children: List.generate(
              5,
              (index) => const Icon(
                Icons.star,
                size: 16,
                color: Colors.amber,
              ),
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
          'DJ club in the core center of Novi Sad,\nfeaturing the best DJs in town.',
        ),
        const SizedBox(height: 8),
        _infoBubble('The hottest place in town!'),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _tag('21+', Icons.cake),
            _tag('DJ Club', Icons.music_note),
            _tag('5km from you', Icons.location_on),
            _tag('TOP PICK 🔥', Icons.local_fire_department, highlight: true),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.phone, color: Colors.white),
              SizedBox(width: 8),
              Text(
                '066 266 166',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
      color: highlight ? Colors.pinkAccent : Colors.white.withOpacity(0.12),
      borderRadius: BorderRadius.circular(16),
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
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/images/PUPIN_MAPA.png',
        height: 180,
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
        Image.asset(
          'assets/images/LOGO.png',
          height: 46,
        ),
        const Icon(Icons.person_outline, color: Colors.white, size: 28),
      ],
    ),
  );
}