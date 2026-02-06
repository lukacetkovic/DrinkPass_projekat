import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final bool isLoggedIn;

  const HomeScreen({
    super.key,
    this.isLoggedIn = true, // ovde kucamo false ako zelimo da vidimo GUEST view, a sa true je LOGGED IN view
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      _topBar(),
                      const SizedBox(height: 16),
                      _topPickSection(isLoggedIn),
                      const SizedBox(height: 32),
                      _mostPopularSection(isLoggedIn),
                      if (isLoggedIn) ...[
                        const SizedBox(height: 32),
                        _bestOffersSection(isLoggedIn),
                      ],
                    ],
                  ),
                ),
              ),
              _bottomNavBar(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _topBar() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        const Icon(Icons.search, color: Colors.white),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pretrazi...',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _topPickSection(bool isLoggedIn) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'PUPIN BAR - TOP PICK 🔥',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                'assets/images/PUPIN_BAR.png',
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              if (isLoggedIn)
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _mostPopularSection(bool isLoggedIn) {
  return _gridSection(
    title: 'MOST POPULAR',
    items: [
      _PopularCard(
        image: 'assets/images/BAJA_MALI.png',
        title: 'SPLAV DVA GALEBA',
        subtitle: 'Baja Mali Knindza',
        rating: 4.5,
        offerText: 'GIN & TONIC x2',
        isLoggedIn: isLoggedIn,
      ),
      _PopularCard(
        image: 'assets/images/ALEKSANDRA.png',
        title: 'SPLAV CRISTAL',
        subtitle: 'Aleksandra Prijovic',
        rating: 5,
        offerText: 'VODKA + ENERGY',
        isLoggedIn: isLoggedIn,
      ),
      _PopularCard(
        image: 'assets/images/PERLA.png',
        title: 'SPLAV PERLA',
        subtitle: 'El Fuego bend',
        rating: 4,
        offerText: 'WHISKEY SOUR',
        isLoggedIn: isLoggedIn,
      ),
      _PopularCard(
        image: 'assets/images/SHOWROOM.png',
        title: 'SHOWROOM',
        subtitle: 'Boban Rajovic',
        rating: 4.5,
        offerText: 'MOJITO NIGHT',
        isLoggedIn: isLoggedIn,
      ),
    ],
  );
}

Widget _bestOffersSection(bool isLoggedIn) {
  return _gridSection(
    title: 'BEST OFFERS',
    items: [
      _PopularCard(
        image: 'assets/images/WERIGE.png',
        title: 'WERIGE',
        subtitle: 'Biba',
        rating: 4,
        offerText: 'JAMESON + 4 COLA',
        isLoggedIn: isLoggedIn,
      ),
      _PopularCard(
        image: 'assets/images/PARADISO.png',
        title: 'PARADISO',
        subtitle: 'Nucci',
        rating: 4.5,
        offerText: 'BELVEDERE + 4 DJUS',
        isLoggedIn: isLoggedIn,
      ),
      _PopularCard(
        image: 'assets/images/DISKONT.png',
        title: 'DISKONT BAR',
        subtitle: 'DJ Party',
        rating: 4,
        offerText: 'VODKA NIGHT',
        isLoggedIn: isLoggedIn,
      ),
      _PopularCard(
        image: 'assets/images/KALEM.png',
        title: 'KALEM',
        subtitle: 'Live band',
        rating: 3.5,
        offerText: 'APEROL SPRITZ',
        isLoggedIn: isLoggedIn,
      ),
    ],
  );
}

Widget _gridSection({
  required String title,
  required List<Widget> items,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
      const SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.72,
          children: items,
        ),
      ),
    ],
  );
}

class _PopularCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final double rating;
  final String? offerText;
  final bool isLoggedIn;

  const _PopularCard({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.isLoggedIn,
    this.offerText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              if (isLoggedIn && offerText != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    offerText!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
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
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white70,
            fontFamily: 'Poppins',
            fontSize: 11,
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