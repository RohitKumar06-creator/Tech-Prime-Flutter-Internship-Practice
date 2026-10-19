/*
import 'package:firebase_practice/utils/utils.dart';
import 'package:firebase_practice/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postContller = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Post")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            TextFormField(
              maxLines: 4,
              controller: postContller,
              decoration: InputDecoration(
                hintText: "What is in your mind?",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            RoundButton(
              title: "Add",
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });
                databaseRef
                    .child('1')
                    .set({'title': postContller.text.toString(), 'id': 1})
                    .then((value) {
                      Utils.toastMessage('Post added');
                      setState(() {
                        loading = false;
                      });
                    })
                    .onError((error, stackTrace) {
                      Utils.toastMessage(error.toString());
                      setState(() {
                        loading = false;
                      });
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

*/
