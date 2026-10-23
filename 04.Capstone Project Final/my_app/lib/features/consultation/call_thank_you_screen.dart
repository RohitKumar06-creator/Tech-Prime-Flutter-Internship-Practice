import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../home/home_screen.dart';

class CallThankYouScreen extends StatefulWidget {
  const CallThankYouScreen({super.key});

  @override
  State<CallThankYouScreen> createState() => _CallThankYouScreenState();
}

class _CallThankYouScreenState extends State<CallThankYouScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Stack(
            children: [
              // Floating Animated Confetti Streamers Layer[cite: 31]
              AnimatedBuilder(
                animation: _animController,
                builder: (context, _) {
                  return CustomPaint(
                    painter: ConfettiPainter(_animController.value),
                    child: Container(),
                  );
                },
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  // Center Thumbs Up Badge Image / Graphic[cite: 31]
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('👍', style: TextStyle(fontSize: 70)),
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Headline Text[cite: 31]
                  const Text(
                    'Thank You!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Description Text[cite: 31]
                  const Text(
                    'We really appreciate you using Ecare.',
                    style: TextStyle(fontSize: 15, color: AppColors.textMuted),
                  ),
                  const Spacer(),

                  // Back to Home Button[cite: 31]
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (route) => false,
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
                        'Back to Home',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Painter for Rendering Floating Animated Confetti Ribbons[cite: 31]
class ConfettiPainter extends CustomPainter {
  final double animationValue;

  ConfettiPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      const Color(0xFF29B6F6),
      const Color(0xFF26A69A),
      const Color(0xFFFF7043),
      const Color(0xFFFFCA28),
      const Color(0xFFAB47BC),
    ];

    final random = Random(42);

    for (int i = 0; i < 15; i++) {
      final paint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.fill;

      final startX = random.nextDouble() * size.width;
      final startY =
          ((random.nextDouble() * size.height) +
              (animationValue * size.height)) %
          size.height;

      final path = Path()
        ..moveTo(startX, startY)
        ..quadraticBezierTo(
          startX + (sin(animationValue * pi * 2 + i) * 20),
          startY + 20,
          startX + 10,
          startY + 40,
        )
        ..lineTo(startX + 16, startY + 40)
        ..quadraticBezierTo(
          startX + (sin(animationValue * pi * 2 + i) * 20) + 6,
          startY + 20,
          startX + 6,
          startY,
        )
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter oldDelegate) => true;
}
