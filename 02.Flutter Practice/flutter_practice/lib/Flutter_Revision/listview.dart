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
        title: Text("ListView Practice"),
        centerTitle: true,
        // backgroundColor: Colors.blue,
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "One",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Two",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Three",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Four",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Five",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
