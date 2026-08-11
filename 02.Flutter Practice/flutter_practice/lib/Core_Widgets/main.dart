import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Widgets"),
        ),

        body: ListView(
          padding: const EdgeInsets.all(16),

          children: [

            // ================= TEXT =================

            const Text(
              "Welcome to Flutter",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),


            // ================= CONTAINER =================

            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blue,
              child: const Text(
                "This is a Container",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),

            const SizedBox(height: 20),


            // ================= ROW =================

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.home),
                Icon(Icons.favorite),
                Icon(Icons.settings),
              ],
            ),

            const SizedBox(height: 20),


            // ================= COLUMN =================

            Column(
              children: const [
                Text("Item 1"),
                Text("Item 2"),
                Text("Item 3"),
              ],
            ),

            const SizedBox(height: 20),


            // ================= STACK =================

            SizedBox(
              height: 150,

              child: Stack(
                alignment: Alignment.center,

                children: [

                  Container(
                    width: 150,
                    height: 150,
                    color: Colors.orange,
                  ),

                  const Text(
                    "Stack",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),


            // ================= IMAGE =================

            Image.network(
              "https://picsum.photos/300/150",
              height: 150,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 20),


            // ================= ICON =================

            const Icon(
              Icons.favorite,
              size: 50,
              color: Colors.red,
            ),

            const SizedBox(height: 20),


            // ================= CARD =================

            Card(
              elevation: 4,

              child: const Padding(
                padding: EdgeInsets.all(20),

                child: Text(
                  "This is a Card",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 20),


            // ================= LISTVIEW =================

            const Text(
              "ListView",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 150,

              child: ListView(
                children: const [

                  Card(
                    child: ListTile(
                      leading: Icon(Icons.book),
                      title: Text("Book 1"),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: Icon(Icons.book),
                      title: Text("Book 2"),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: Icon(Icons.book),
                      title: Text("Book 3"),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),


            // ================= GRIDVIEW =================

            const Text(
              "GridView",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 250,

              child: GridView.count(
                crossAxisCount: 2,

                children: const [

                  Card(
                    child: Center(
                      child: Text("Grid 1"),
                    ),
                  ),

                  Card(
                    child: Center(
                      child: Text("Grid 2"),
                    ),
                  ),

                  Card(
                    child: Center(
                      child: Text("Grid 3"),
                    ),
                  ),

                  Card(
                    child: Center(
                      child: Text("Grid 4"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}