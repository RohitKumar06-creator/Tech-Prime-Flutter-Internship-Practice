import 'package:firebase_practice/ui/auth/login_with_phone_number.dart';
import 'package:firebase_practice/ui/auth/signup_screen.dart';
import 'package:firebase_practice/ui/posts/posts_screen.dart';
// import 'package:firebase_practice/ui/auth/login_with_phone_number.dart';
import 'package:firebase_practice/utils/utils.dart';
import 'package:firebase_practice/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text.toString(),
        )
        .then((value) {
          Utils.toastMessage(value.user!.email.toString());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostsScreen()),
          );
          setState(() {
            loading = false;
          });
        })
        .onError((error, stackTrace) {
          debugPrint(error.toString());
          Utils.toastMessage(error.toString());
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false, title: Text("Login")),

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
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,

                      decoration: const InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.alternate_email),
                      ),

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      keyboardType: TextInputType.text,

                      // FIXED
                      controller: passwordController,

                      obscureText: true,

                      decoration: const InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                      ),

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              RoundButton(
                title: "Login",
                // loading = loading

                onTap: () {
                  // FIXED
                  if (_formKey.currentState!.validate()) {
                    // Firebase login code will go here
                    login();
                  }
                },
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text("Don't have an account?"),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },

                    child: Text('Sign up'),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginWithPhoneNumber(),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(child: Text("Login With Phone Number")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
