import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../navigation/app_routes.dart';
import '../state/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Image.asset('assets/images/LOGO.png', height: 50),
                      const SizedBox(height: 26),

                      _searchBar(),
                      const SizedBox(height: 32),

                      _sectionTitle('TOP PICK'),
                      const SizedBox(height: 18),
                      _topPick(context, isLoggedIn),

                      const SizedBox(height: 40),
                      _sectionTitle('MOST POPULAR'),
                      const SizedBox(height: 18),
                      _popularGrid(isLoggedIn),

                      if (isLoggedIn) ...[
                        const SizedBox(height: 40),
                        _sectionTitle('BEST OFFERS'),
                        const SizedBox(height: 18),
                        _bestOffersGrid(isLoggedIn),
                      ],

                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
              _glassBottomNav(context), // moramo da dodamo i "contenxt" jer widget prima build context 
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.14)),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.white70, size: 20),
          SizedBox(width: 10),
          Text(
            'Search clubs, events...',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _topPick(BuildContext context, bool isLoggedIn) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRoutes.clubDetails),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  'assets/images/PUPIN_BAR.png',
                  fit: BoxFit.cover,
                ),
              ),
              if (isLoggedIn)
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: _offerTag('JACK DANIELS + COLA x2 = 50€'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _popularGrid(bool isLoggedIn) {
    return _grid([
      _card(
        image: 'assets/images/BAJA_MALI.png',
        title: 'SPLAV DVA GALEBA',
        subtitle: 'Baja Mali Knindza',
        offer: 'GIN & TONIC x2 = 70€',
        isLoggedIn: isLoggedIn,
      ),
      _card(
        image: 'assets/images/ALEKSANDRA.png',
        title: 'SPLAV CRISTAL',
        subtitle: 'Aleksandra Prijovic',
        offer: 'VODKA + ENERGY = 80€',
        isLoggedIn: isLoggedIn,
      ),
      _card(
        image: 'assets/images/PERLA.png',
        title: 'SPLAV PERLA',
        subtitle: 'El Fuego bend',
        offer: 'WHISKEY SOUR = 40€',
        isLoggedIn: isLoggedIn,
      ),
      _card(
        image: 'assets/images/SHOWROOM.png',
        title: 'SHOWROOM',
        subtitle: 'Boban Rajovic',
        offer: 'MOJITO NIGHT = 10€',
        isLoggedIn: isLoggedIn,
      ),
    ]);
  }

  Widget _bestOffersGrid(bool isLoggedIn) {
    return _grid([
      _card(
        image: 'assets/images/WERIGE.png',
        title: 'WERIGE',
        subtitle: 'Biba',
        offer: 'WHISKEY + 4 COLA = 40€',
        isLoggedIn: isLoggedIn,
      ),
      _card(
        image: 'assets/images/PARADISO.png',
        title: 'PARADISO',
        subtitle: 'Nucci',
        offer: 'VODKA + 4 JUICE = 70€',
        isLoggedIn: isLoggedIn,
      ),
      _card(
        image: 'assets/images/DISKONT.png',
        title: 'DISKONT BAR',
        subtitle: 'DJ Party',
        offer: 'VODKA + 4 JUICE = 60€',
        isLoggedIn: isLoggedIn,
      ),
      _card(
        image: 'assets/images/KALEM.png',
        title: 'KALEM',
        subtitle: 'Live band',
        offer: 'APEROL = 20€',
        isLoggedIn: isLoggedIn,
      ),
    ]);
  }

  Widget _grid(List<Widget> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 0.72,
        children: items,
      ),
    );
  }

  Widget _card({
    required String image,
    required String title,
    required String subtitle,
    required String offer,
    required bool isLoggedIn,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.asset(image, fit: BoxFit.cover),
              ),
              if (isLoggedIn)
                Positioned(bottom: 8, left: 8, child: _offerTag(offer)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: Colors.white,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _offerTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

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
}
