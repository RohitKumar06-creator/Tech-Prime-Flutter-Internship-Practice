import 'package:flutter/material.dart';

// Models & Widgets
import '../models/promo_banner.dart';
import '../widgets/promo_card.dart';
import '../widgets/categories_section.dart';
import '../widgets/popular_section.dart';
import '../widgets/location_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../screens/shopping_cart_screen.dart';

class FoodCatalogue extends StatefulWidget {
  const FoodCatalogue({super.key});

  @override
  State<FoodCatalogue> createState() => _FoodCatalogueState();
}

class _FoodCatalogueState extends State<FoodCatalogue> {
  int _selectedIndex = 0;

  List<PromoBanner> get _dummyBanners => [
    PromoBanner(
      imagePath: 'assets/images/Card1.png',
      tag: "Limited Offer",
      title: "50% Off Your First Pizza",
      subtitle: "Valid until Friday. T&Cs apply",
    ),
    PromoBanner(
      imagePath: 'assets/images/Card2.png',
      tag: "Best Value",
      title: "Buy 1 Get 1 Free Burger",
      subtitle: "Available on selected items.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Promo Banners
              SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _dummyBanners.length,
                  itemBuilder: (context, index) {
                    final banner = _dummyBanners[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: PromoCard(banner: banner),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),
              CategoriesSection(),
              const SizedBox(height: 24),
              PopularSection(),
              const SizedBox(height: 12),
              const LocationBar(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),

      // Extracted Bottom Navigation Widget
      // Inside lib/screens/food_catalogue.dart
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 2) {
            // Index 2 is Cart
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShoppingCartScreen(),
              ),
            );
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
    );
  }
}
