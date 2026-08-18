import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    ),
  );
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: formKey,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              const Icon(
                Icons.lock,
                size: 60,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 30),

              // EMAIL
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your email";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              // PASSWORD
              TextFormField(
                obscureText: true,

                decoration: const InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your password";
                  }

                  if (value.length < 6) {
                    return "Password must be 6 characters";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // BUTTON
              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {

                    if (formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Login successful!"),
                        ),
                      );
                    }

                  },

                  child: const Text("Login"),
                ),
              ),

              TextButton(
                onPressed: () {},
                child: const Text("Forgot Password?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}