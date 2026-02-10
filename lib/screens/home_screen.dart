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
      Color.fromARGB(255, 44, 20, 99),
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
                      _popularGrid(context, isLoggedIn),
                      if (isLoggedIn) ...[
                        const SizedBox(height: 40),
                        _sectionTitle('BEST OFFERS'),
                        const SizedBox(height: 18),
                        _bestOffersGrid(context, isLoggedIn),
                      ],
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
              _glassBottomNav(context),
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
        onTap: () => _handleClubTap(context, isLoggedIn),
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

  Widget _popularGrid(BuildContext context, bool isLoggedIn) {
    return _grid(context, isLoggedIn, [
      _card(
        context: context,
        image: 'assets/images/BAJA_MALI.png',
        title: 'SPLAV DVA GALEBA',
        subtitle: 'Baja Mali Knindza',
        offer: 'GIN & TONIC x2 = 70€',
        isLoggedIn: isLoggedIn,
      ),
      _card(
        context: context,
        image: 'assets/images/ALEKSANDRA.png',
        title: 'SPLAV CRISTAL',
        subtitle: 'Aleksandra Prijovic',
        offer: 'VODKA + ENERGY = 80€',
        isLoggedIn: isLoggedIn,
      ),
      _card(
        context: context,
        image: 'assets/images/PERLA.png',
        title: 'SPLAV PERLA',
        subtitle: 'El Fuego bend',
        offer: 'WHISKEY SOUR = 40€',
        isLoggedIn: isLoggedIn,
      ),
      _card(
        context: context,
        image: 'assets/images/SHOWROOM.png',
        title: 'SHOWROOM',
        subtitle: 'Boban Rajovic',
        offer: 'MOJITO NIGHT = 10€',
        isLoggedIn: isLoggedIn,
      ),
    ]);
  }

  Widget _bestOffersGrid(BuildContext context, bool isLoggedIn) {
    return _grid(context, isLoggedIn, [
      _card(
        context: context,
        image: 'assets/images/WERIGE.png',
        title: 'WERIGE',
        subtitle: 'Biba',
        offer: 'WHISKEY + 4 COLA = 40€',
        isLoggedIn: isLoggedIn,
      ),
      _card(
        context: context,
        image: 'assets/images/PARADISO.png',
        title: 'PARADISO',
        subtitle: 'Nucci',
        offer: 'VODKA + 4 JUICE = 70€',
        isLoggedIn: isLoggedIn,
      ),
      _card(
        context: context,
        image: 'assets/images/DISKONT.png',
        title: 'DISKONT BAR',
        subtitle: 'DJ Party',
        offer: 'VODKA + 4 JUICE = 60€',
        isLoggedIn: isLoggedIn,
      ),
      _card(
        context: context,
        image: 'assets/images/KALEM.png',
        title: 'KALEM',
        subtitle: 'Live band',
        offer: 'APEROL = 20€',
        isLoggedIn: isLoggedIn,
      ),
    ]);
  }

  Widget _grid(BuildContext context, bool isLoggedIn, List<Widget> items) {
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
    required BuildContext context,
    required String image,
    required String title,
    required String subtitle,
    required String offer,
    required bool isLoggedIn,
  }) {
    return GestureDetector(
      onTap: () => _handleClubTap(context, isLoggedIn),
      child: Column(
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
      ),
    );
  }

  Widget _offerTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF4D6D).withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
          BoxShadow(
            color: const Color(0xFFB5179E).withOpacity(0.45),
            blurRadius: 30,
            offset: const Offset(0, 0),
          ),
        ],
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
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            },
            child: Image.asset('assets/images/LOGO.png', height: 42),
          ),
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

  void _handleClubTap(BuildContext context, bool isLoggedIn) {
    if (isLoggedIn) {
      Navigator.pushNamed(context, AppRoutes.clubDetails);
    } else {
      _showLoginRequiredDialog(context);
    }
  }

  void _showLoginRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 28),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 22),
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
                  'Premium feature',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Log in to view club details,\nexclusive offers and reservations.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 26),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF4D6D), Color(0xFFB5179E)],
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF4D6D).withOpacity(0.6),
                          blurRadius: 14,
                          offset: const Offset(0, 0),
                        ),
                        BoxShadow(
                          color: const Color(0xFFB5179E).withOpacity(0.45),
                          blurRadius: 32,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.35),
                        width: 1.4,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white70,
                          letterSpacing: 0.8,
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
}
