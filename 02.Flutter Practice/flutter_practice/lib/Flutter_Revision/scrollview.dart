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
        title: Text("ScrollView Practice"),
        centerTitle: true,
        // backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 11),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 11),
                        height: 200,
                        width: 200,
                        color: Colors.red,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 11),
                        height: 200,
                        width: 200,
                        color: Colors.orange,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 11),
                        height: 200,
                        width: 200,
                        color: Colors.yellow,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 11),
                        height: 200,
                        width: 200,
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 11),
                height: 200,
                // width: 200,
                color: Colors.yellow,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 11),
                height: 200,
                // width: 200,
                color: Colors.green,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 11),
                height: 200,
                // width: 200,
                color: Colors.pink,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 11),
                height: 200,
                // width: 200,
                color: Colors.teal,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 11),
                height: 200,
                // width: 200,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
