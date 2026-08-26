import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(0.15), width: 1),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: const Color(0xFFEF5350),
        unselectedItemColor: const Color(0xFF9E9E9E),
        selectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        items: [
          // Home Tab
          BottomNavigationBarItem(
            icon: currentIndex == 0
                ? Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF5350),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.home_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                : const Icon(Icons.home_outlined, size: 24),
            label: 'Home',
          ),

          // Orders Tab
          const BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined, size: 24),
            activeIcon: Icon(Icons.receipt_long, size: 24),
            label: 'Orders',
          ),

          // Cart Tab
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined, size: 24),
            activeIcon: Icon(Icons.shopping_cart, size: 24),
            label: 'Cart',
          ),

          // Alerts Tab
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined, size: 24),
            activeIcon: Icon(Icons.notifications, size: 24),
            label: 'Alerts',
          ),

          // Profile Tab
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded, size: 24),
            activeIcon: Icon(Icons.person_rounded, size: 24),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
