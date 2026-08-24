import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inkwell Practice"),
        centerTitle: true,
        // backgroundColor: Colors.blue,
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            print("Tapped on Container");
          },
          onLongPress: () {
            print("Long Pressed on Container");
          },
          onDoubleTap: () {
            print("Double-Tapped on Container");
          },
          child: Container(
            width: 200,
            height: 200,
            color: Colors.amber,
            child: Center(
              child: InkWell(
                onTap: () {
                  print("Text Widget Was Tapped");
                },
                child: Text(
                  "Click Here",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
