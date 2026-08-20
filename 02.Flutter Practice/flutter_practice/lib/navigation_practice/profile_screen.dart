import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,

      child: Scaffold(

        appBar: AppBar(
          title: const Text("My Profile"),

          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person),
                text: "Profile",
              ),

              Tab(
                icon: Icon(Icons.settings),
                text: "Settings",
              ),
            ],
          ),
        ),

        body: const TabBarView(
          children: [

            // ================================================
            // TAB 1
            // ================================================

            Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  CircleAvatar(
                    radius: 45,

                    child: Icon(
                      Icons.person,
                      size: 45,
                    ),
                  ),

                  SizedBox(height: 15),

                  Text(
                    "Flutter Developer",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    "Learning Flutter 🚀",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // ================================================
            // TAB 2
            // ================================================

            Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.settings,
                    size: 60,
                    color: Colors.deepPurple,
                  ),

                  SizedBox(height: 15),

                  Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
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