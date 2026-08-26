import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            // BACKGROUND IMAGE
            Positioned.fill(
              child: Image.asset(
                'assets/images/Splash_Screen.jpg',
                fit: BoxFit.cover,
              ),
            ),

            // BOTTOM GRADIENT
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.35, 0.55, 0.75, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black54,
                      Colors.black87,
                    ],
                  ),
                ),
              ),
            ),

            // TEXT + BUTTON
            SafeArea(
              child: Column(
                children: [
                  const Spacer(flex: 7),

                  // HEADLINE
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      '"Delicious Moments,\n'
                      'Delivered to Your\n'
                      'Doorstep!"',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.4,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),

                  const Spacer(flex: 4),

                  // GET STARTED BUTTON
                  Padding(
                    padding: EdgeInsets.only(
                      left: 48.w,
                      right: 48.w,
                      bottom: 32.h,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 54.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEF514B),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: Text(
                          'Get Started',
                          style: GoogleFonts.montserrat(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
