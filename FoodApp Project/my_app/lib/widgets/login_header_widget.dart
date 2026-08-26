import 'package:flutter/material.dart';

class LoginHeaderImage extends StatelessWidget {
  const LoginHeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 380,
      child: ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.6, 0.95, 1.0],
            colors: [
              Colors.black,
              Colors.black,
              Colors.transparent,
              Colors.transparent,
            ],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstIn,
        child: Image.asset('assets/images/Login2.png', fit: BoxFit.cover),
      ),
    );
  }
}
