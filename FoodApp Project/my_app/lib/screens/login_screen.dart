import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'food_catalogue.dart';

import '../widgets/login_header_widget.dart';
import '../widgets/google_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void goToFoodCatalogue(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FoodCatalogue()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            // Top Header Image Component
            const LoginHeaderImage(),

            // Form Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    Text(
                      'Welcome back',
                      style: GoogleFonts.montserrat(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF202020),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      'Sign in to continue your culinary journey.',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: const Color(0xFF666666),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Google Button Component
                    GoogleLoginButton(
                      onPressed: () {
                        // Google auth action
                      },
                    ),

                    const SizedBox(height: 38),

                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0xFFE7C4C4),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OR',
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              color: const Color(0xFF666666),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0xFFE7C4C4),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Email Field
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        'Email Address',
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF594141),
                        ),
                      ),
                    ),

                    const SizedBox(height: 7),

                    SizedBox(
                      height: 56,
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFF202020),
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: 'chef@example.com',
                          hintStyle: GoogleFonts.montserrat(
                            color: const Color(0xFFC5C9D1),
                            fontSize: 16,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFFE9A6A6),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFFFF5A61),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => goToFoodCatalogue(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5961),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        child: Text(
                          'Sign In with Email',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 66),

                    // Sign Up Link
                    Center(
                      child: GestureDetector(
                        onTap: () => goToFoodCatalogue(context),
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: const Color(0xFF666666),
                            ),
                            children: [
                              const TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: 'Sign up',
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xFFE53935),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Footer Links
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Privacy Policy',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            color: const Color(0xFF444444),
                          ),
                        ),
                        const SizedBox(width: 28),
                        Text(
                          'Terms of Service',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            color: const Color(0xFF444444),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
