import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/ui/auth/verify_code.dart';
import 'package:firebase_practice/utils/utils.dart';
import 'package:firebase_practice/widgets/round_button.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading = false;

  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  void sendVerificationCode() {
    final phoneNumber = phoneNumberController.text.trim();

    if (phoneNumber.isEmpty) {
      Utils.toastMessage('Please enter your phone number');
      return;
    }

    setState(() {
      loading = true;
    });

    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,

      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await auth.signInWithCredential(credential);

          if (!mounted) return;

          setState(() {
            loading = false;
          });

          Utils.toastMessage('Phone number verified successfully');
        } on FirebaseAuthException catch (e) {
          if (!mounted) return;

          setState(() {
            loading = false;
          });

          Utils.toastMessage(e.message ?? 'Verification failed');
        }
      },

      verificationFailed: (FirebaseAuthException e) {
        if (!mounted) return;

        setState(() {
          loading = false;
        });

        Utils.toastMessage(e.message ?? 'Failed to send verification code');
      },

      codeSent: (String verificationId, int? resendToken) {
        if (!mounted) return;

        setState(() {
          loading = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VerifyCodeScreen(verificationId: verificationId),
          ),
        );
      },

      codeAutoRetrievalTimeout: (String verificationId) {
        if (!mounted) return;

        setState(() {
          loading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login with Phone Number')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 80),

            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: '+1 234 3455 234',
                prefixIcon: Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 80),

            RoundButton(
              title: 'Login',
              loading: loading,
              onTap: sendVerificationCode,
            ),
          ],
        ),
      ),
    );
  }
}
