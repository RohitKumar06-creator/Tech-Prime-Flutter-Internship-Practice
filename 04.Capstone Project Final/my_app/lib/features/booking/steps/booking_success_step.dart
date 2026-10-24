import 'package:flutter/material.dart';

import '../viewmodels/booking_viewmodel.dart';

class BookingSuccessStep extends StatelessWidget {
  final BookingViewModel? viewModel;
  final String? doctorName;
  final String? specialty;
  final String? appointmentTime;

  const BookingSuccessStep({
    super.key,
    this.viewModel,
    this.doctorName,
    this.specialty,
    this.appointmentTime,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4FC3F7); // App Sky Blue
    const successGreen = Color(0xFF42C86A); // Green checkmark fill

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Green Success Circle Badge
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: successGreen.withOpacity(0.18),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 84,
                    height: 84,
                    decoration: const BoxDecoration(
                      color: successGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 52,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Title & Subtitle
              const Text(
                'Successfully',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your appointment has been requested',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Color(0xFF8A9AAC)),
              ),
              const SizedBox(height: 32),

              // Notice / Info Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF0), // Soft cream background
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFFFD580), // Soft amber border
                    width: 1,
                  ),
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 13.5,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: 'If you have any problem or any issue\nand you need change your visit,\nplease call ',
                      ),
                      TextSpan(
                        text: '021 9012301',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Add Google Calendar Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Added to Google Calendar!'),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/calender.png',
                        width: 24,
                        height: 24,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Add Google Calendar',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Back to Home Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text(
                    'Back to Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
