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
  var arrNames = ['Rohit', 'Jayant', 'Akash', 'Sanjay', 'Danish'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ListView Practice"), centerTitle: true),

      body: Column(
        children: [
          // ==========================================
          // OLD LISTVIEW BUILDER
          // ==========================================

          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Text(
                  arrNames[index],
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },

              itemCount: arrNames.length,
              itemExtent: 100,
              scrollDirection: Axis.horizontal,
            ),
          ),

          // ==========================================
          // SEPARATOR
          // ==========================================
          const Divider(thickness: 2),

          // ==========================================
          // LISTVIEW SEPARATED
          // ==========================================
          Expanded(
            child: ListView.separated(
              itemCount: arrNames.length,

              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.person),

                  title: Text(arrNames[index]),
                );
              },

              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
        ],
      ),
    );
  }
}
