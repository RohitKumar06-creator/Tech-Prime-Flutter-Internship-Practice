import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../auth/login_screen.dart';
import '../auth/sign_up_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // ecare Logo Header (logo.png)
              Image.asset(
                'assets/images/logo.png',
                height: 40,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_box_rounded,
                      color: Color(0xFF4FC3F7),
                      size: 36,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'ecare',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Hero Doctors Section with Gradient Glow & Staked Doctors
              SizedBox(
                height: 320,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Soft Circular Gradient Glow behind doctors
                    Container(
                      width: 280,
                      height: 280,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Color(0xFFE0F7FA), // Light cyan/blue glow center
                            Color(0xFFEDE7F6), // Soft lavender tint
                            Colors.white, // Fade into background
                          ],
                          stops: [0.3, 0.7, 1.0],
                        ),
                      ),
                    ),

                    // // Oval Asset Background with Radial Blend
                    // Image.asset(
                    //   'assets/images/background.png',
                    //   height: 300,
                    //   width: double.infinity,
                    //   fit: BoxFit.contain,
                    //   errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    // ),

                    // Female Doctor (Placed behind on the right)
                    Positioned(
                      right: 10,
                      bottom: 0,
                      child: Image.asset(
                        'assets/images/doctor_female.png',
                        height: 270,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.person_outline,
                          size: 120,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    // Male Doctor (Placed in front on the left)
                    Positioned(
                      left: 10,
                      bottom: 0,
                      child: Image.asset(
                        'assets/images/doctor_male.png',
                        height: 290,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.person,
                          size: 120,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Headline Text in Health-Themed Deep Purple (Color: #1B0947)
              const Text(
                'Improve the Quality\nof Service for Patient\nHappiness',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B0947), // Deep health purple shade
                  height: 1.25,
                ),
              ),

              const Spacer(),

              // Get Started Primary Action Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4FC3F7),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Login Option Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Have an account? ',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFF4FC3F7),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
