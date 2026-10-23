import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_new_password_screen.dart';
import 'success_screen.dart';
import '../../core/constants/app_colors.dart';
// import 'create_new_password_screen.dart';
// import '../home/home_screen.dart';
import '../profile/viewmodels/profile_viewmodel.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email;
  final String expectedOtp;
  // final String email;
  // final String expectedOtp;
  final String username;
  final String gender;
  final String password; // Added field
  final bool isPasswordReset;

  const VerifyCodeScreen({
    super.key,
    required this.email,
    required this.expectedOtp,
    this.username = '',
    this.gender = 'Not Specified',
    this.password = '',
    this.isPasswordReset = false,
  });

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  late String _activeOtp;
  int _resendCountdown = 60;
  Timer? _timer;
  bool _canResend = false;
  bool _isVerifying = false;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    _activeOtp = widget.expectedOtp;
    _startCountdownTimer();
  }

  void _startCountdownTimer() {
    setState(() {
      _resendCountdown = 60;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
      } else {
        _timer?.cancel();
        setState(() => _canResend = true);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  String _getObfuscatedEmail(String email) {
    if (!email.contains('@')) return email;
    final parts = email.split('@');
    final name = parts[0];
    if (name.length <= 3) return '${name[0]}***@${parts[1]}';
    return '${name.substring(0, 4)}xxx@${parts[1]}';
  }

  Future<void> _onResendCode() async {
    setState(() => _isResending = true);

    try {
      // 1. Generate new 4-digit code
      final newOtp = (Random().nextInt(9000) + 1000).toString();

      // 2. Update Firestore document with new OTP
      await FirebaseFirestore.instance.collection('otps').doc(widget.email).set(
        {'otp': newOtp, 'createdAt': FieldValue.serverTimestamp()},
      );

      // Debug console log
      print('========================================');
      print('🔑 RESENT NEW OTP FOR ${widget.email}: $newOtp');
      print('========================================');

      setState(() {
        _activeOtp = newOtp;
      });

      // Clear existing input fields
      for (var controller in _controllers) {
        controller.clear();
      }
      _focusNodes[0].requestFocus();

      // Restart countdown timer
      _startCountdownTimer();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('A new verification code has been generated.'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to resend code: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  Future<void> _onVerify() async {
    final enteredCode = _controllers.map((c) => c.text).join();

    if (enteredCode.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the full 4-digit code')),
      );
      return;
    }

    if (enteredCode == _activeOtp) {
      setState(() => _isVerifying = true);

      try {
        if (widget.isPasswordReset) {
          // ROUTE TO CREATE NEW PASSWORD SCREEN FOR PASSWORD RESET FLOW
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => CreateNewPasswordScreen(email: widget.email),
              ),
            );
          }
        } else {
          // Save metadata including password to Firestore for Sign Up flow
          final User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set({
                  'uid': user.uid,
                  'username': widget.username,
                  'email': widget.email,
                  'gender': widget.gender,
                  'password': widget
                      .password, // Saves user password to Firestore document
                  'createdAt': FieldValue.serverTimestamp(),
                });
          }

          if (mounted) {
            final viewModel = Provider.of<ProfileViewModel>(
              context,
              listen: false,
            );
            viewModel.loginUser(
              usernameOrEmail: widget.username.isNotEmpty
                  ? widget.username
                  : widget.email,
            );

            // ROUTE TO ACCOUNT VERIFIED SUCCESS SCREEN
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SuccessScreen()),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error saving data: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) setState(() => _isVerifying = false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid verification code. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textDark,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Verify Code',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B0947),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please enter the code we just sent to email\n${_getObfuscatedEmail(widget.email)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textMuted,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 36),

              // 4 Circular Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 60,
                    height: 60,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: const Color(0xFFF2F4F7),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xFF4FC3F7),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          _focusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 28),

              // Dynamic Timer / Resend Code
              Center(
                child: _isResending
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF4FC3F7),
                        ),
                      )
                    : _canResend
                    ? TextButton(
                        onPressed: _onResendCode,
                        child: const Text(
                          'Resend Code',
                          style: TextStyle(
                            color: Color(0xFF4FC3F7),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      )
                    : Text.rich(
                        TextSpan(
                          text: 'Resend code in ',
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  '00:${_resendCountdown.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              const Spacer(),

              // Submit Primary Action Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isVerifying ? null : _onVerify,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4FC3F7),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isVerifying
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
