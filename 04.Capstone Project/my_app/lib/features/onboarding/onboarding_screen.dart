import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../auth/sign_in_screen.dart';
import '../auth/sign_up_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header Brand Logo
            Center(
              child: Image.asset(
                AppAssets.logo,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),

            // Middle Doctor Illustration Section
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background Radial Blue Soft Glow
                  Positioned.fill(
                    child: Image.asset(AppAssets.bgGlow, fit: BoxFit.cover),
                  ),

                  // Composite Doctors Image Stack
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: screenSize.width,
                      height: screenSize.height * 0.42,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          // Female Doctor (Right Background Layer)
                          Positioned(
                            right: screenSize.width * 0.05,
                            bottom: 0,
                            child: Image.asset(
                              AppAssets.doctorFemale,
                              height: screenSize.height * 0.35,
                              fit: BoxFit.contain,
                            ),
                          ),
                          // Male Doctor (Left Foreground Layer)
                          Positioned(
                            left: screenSize.width * 0.05,
                            bottom: 0,
                            child: Image.asset(
                              AppAssets.doctorMale,
                              height: screenSize.height * 0.39,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Content Section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 16.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Heading Text
                  const Text(
                    'Improve the Quality\nof Service for Patient\nHappiness',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                      height: 1.25,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Get Started Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUpScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Redirection Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Have an account? ',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignInScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: AppColors.textLink,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
