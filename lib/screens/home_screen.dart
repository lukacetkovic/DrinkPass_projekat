import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final bool isLoggedIn;

  const HomeScreen({
    super.key,
    this.isLoggedIn = true,
  });

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
                      _topPick(isLoggedIn),

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
              _glassBottomNav(),
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
      child: Row(
        children: const [
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

  Widget _topPick(bool isLoggedIn) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                'assets/images/PUPIN_BAR.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.75),
                  ],
                ),
              ),
            ),
            if (isLoggedIn)
              Positioned(
                bottom: 18,
                left: 18,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'JACK DANIELS + COLA x2 = 50€',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _popularGrid(bool isLoggedIn) {
    return _grid([
      _card('assets/images/BAJA_MALI.png', 'SPLAV DVA GALEBA',
          'Baja Mali Knindza', 'GIN & TONIC x2 = 70€', isLoggedIn, 4.5),
      _card('assets/images/ALEKSANDRA.png', 'SPLAV CRISTAL',
          'Aleksandra Prijovic', 'VODKA + ENERGY = 80€', isLoggedIn, 5),
      _card('assets/images/PERLA.png', 'SPLAV PERLA', 'El Fuego bend',
          'WHISKEY SOUR = 40€', isLoggedIn, 4),
      _card('assets/images/SHOWROOM.png', 'SHOWROOM', 'Boban Rajovic',
          'MOJITO NIGHT = 10€', isLoggedIn, 4.5),
    ]);
  }

  Widget _bestOffersGrid(bool isLoggedIn) {
    return _grid([
      _card('assets/images/WERIGE.png', 'WERIGE', 'Biba',
          'WHISKEY + 4 COLA = 40€', isLoggedIn, 4),
      _card('assets/images/PARADISO.png', 'PARADISO', 'Nucci',
          'VODKA + 4 JUICE = 70€', isLoggedIn, 4.5),
      _card('assets/images/DISKONT.png', 'DISKONT BAR', 'DJ Party',
          'VODKA + 4 JUICE = 60€', isLoggedIn, 4),
      _card('assets/images/KALEM.png', 'KALEM', 'Live band',
          'APEROL = 20€', isLoggedIn, 3.5),
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

  Widget _card(
    String image,
    String title,
    String subtitle,
    String offer,
    bool isLoggedIn,
    double rating,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (isLoggedIn)
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      offer,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
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
        if (isLoggedIn) ...[
          const SizedBox(height: 4),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < rating.floor()
                    ? Icons.star
                    : Icons.star_border,
                size: 14,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _glassBottomNav() {
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: primaryGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.home, color: Colors.white),
          ),
          Image.asset('assets/images/LOGO.png', height: 42),
          const Icon(Icons.person_outline, color: Colors.white),
        ],
      ),
    );
  }
}