import 'package:flutter/material.dart';

class LoginHeaderImage extends StatelessWidget {
  const LoginHeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 360,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Login2.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.55, 0.75, 0.90, 1.0],
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Color(0xCCFAFAFA),
                    Color(0xFFFAFAFA),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
