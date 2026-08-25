import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationBar extends StatelessWidget {
  const LocationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Location Pin Icon
              const Icon(
                Icons.location_on_outlined,
                color: Color(0xFFEF5350),
                size: 26,
              ),

              const SizedBox(width: 8),

              // Location Labels
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Location',
                    style: GoogleFonts.montserrat(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF888888),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'New York, NY',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF202020),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Search Icon Button
          IconButton(
            onPressed: () {
              // Action for search
            },
            icon: const Icon(Icons.search, color: Color(0xFF202020), size: 24),
          ),
        ],
      ),
    );
  }
}
