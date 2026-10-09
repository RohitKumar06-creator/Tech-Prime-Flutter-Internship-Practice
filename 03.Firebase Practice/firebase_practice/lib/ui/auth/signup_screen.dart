import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/ui/auth/login_screen.dart';
import 'package:firebase_practice/utils/utils.dart';
import 'package:firebase_practice/widgets/round_button.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Form(
              key: _formKey,

              child: Column(
                children: [
                  // EMAIL
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,

                    decoration: const InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.alternate_email),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Email';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // PASSWORD
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    obscureText: true,

                    decoration: const InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Password';
                      }

                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            // SIGN UP BUTTON
            RoundButton(
              title: "Sign up",

              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    await _auth.createUserWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );

                    print("User created successfully");

                    // SUCCESS TOAST
                    Utils.toastMessage("Account created successfully");

                    if (mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                  }
                  // FIREBASE AUTHENTICATION ERROR
                  on FirebaseAuthException catch (e) {
                    print("Firebase Error: ${e.code}");
                    print("Message: ${e.message}");

                    // ERROR TOAST
                    Utils.toastMessage(e.message ?? "Something went wrong");
                  }
                  // OTHER ERRORS
                  catch (e) {
                    print("Error: $e");

                    Utils.toastMessage("Something went wrong: $e");
                  }
                }
              },
            ),

            const SizedBox(height: 30),

            // LOGIN LINK
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                const Text("Already have an account?"),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },

                  child: const Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
