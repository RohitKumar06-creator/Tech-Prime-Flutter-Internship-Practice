import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/ui/posts/posts_screen.dart';
import 'package:firebase_practice/utils/utils.dart';
import 'package:firebase_practice/widgets/round_button.dart';
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;

  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;

  final codeController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  Future<void> verifyCode() async {
    final smsCode = codeController.text.trim();

    if (smsCode.isEmpty) {
      Utils.toastMessage('Please enter the verification code');
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: smsCode,
      );

      await auth.signInWithCredential(credential);

      if (!mounted) return;

      setState(() {
        loading = false;
      });

      Utils.toastMessage('Login successful');

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const PostsScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      Utils.toastMessage(e.message ?? 'Invalid verification code');
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      Utils.toastMessage('Something went wrong');
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Phone Number')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 80),

            TextFormField(
              controller: codeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter SMS verification code',
                prefixIcon: Icon(Icons.lock),
              ),
            ),

            const SizedBox(height: 80),

            RoundButton(title: 'Verify', loading: loading, onTap: verifyCode),
          ],
        ),
      ),
    );
  }
}
