import 'package:firebase_practice/ui/auth/login_screen.dart';
import 'package:firebase_practice/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostsScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
        actions: [
          IconButton(
            onPressed: () {
              auth
                  .signOut()
                  .then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  })
                  .onError((error, stackTrace) {
                    Utils.toastMessage(error.toString());
                  });
            },
            icon: Icon(Icons.logout_outlined),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
