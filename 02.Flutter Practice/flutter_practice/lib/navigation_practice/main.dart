import 'package:flutter/material.dart';
import 'detail_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Navigation Practice',

      // =====================================================
      // NAMED ROUTES
      // =====================================================

      routes: {
        '/': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
      },

      initialRoute: '/',
    );
  }
}

// ===========================================================
// HOME SCREEN
// ===========================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;

  // =========================================================
  // BOTTOM NAVIGATION SCREENS
  // =========================================================

  final List<Widget> screens = const [
    HomeContent(),
    Center(
      child: Text(
        "Explore",
        style: TextStyle(fontSize: 25),
      ),
    ),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screens[selectedIndex],

      // =====================================================
      // BOTTOM NAVIGATION
      // =====================================================

      bottomNavigationBar:
          NavigationBar(

        selectedIndex: selectedIndex,

        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explore',
          ),

          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ===========================================================
// HOME CONTENT
// ===========================================================

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Flutter Learning",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Navigation Practice",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            // =================================================
            // PUSH / POP EXAMPLE
            // =================================================

            Card(
              child: ListTile(

                leading: const CircleAvatar(
                  child: Icon(Icons.navigation),
                ),

                title: const Text(
                  "Push & Pop",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: const Text(
                  "Open another screen",
                ),

                trailing:
                    const Icon(Icons.arrow_forward),

                onTap: () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (context) =>
                          const DetailScreen(
                        title: "Flutter",
                        description:
                            "You opened this screen using Navigator.push().",
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            // =================================================
            // NAMED ROUTE
            // =================================================

            Card(
              child: ListTile(

                leading: const CircleAvatar(
                  child: Icon(Icons.route),
                ),

                title: const Text(
                  "Named Route",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: const Text(
                  "Navigate using /profile",
                ),

                trailing:
                    const Icon(Icons.arrow_forward),

                onTap: () {

                  Navigator.pushNamed(
                    context,
                    '/profile',
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            // =================================================
            // PASS DATA
            // =================================================

            const Text(
              "Pass Data",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) =>
                        const DetailScreen(
                      title: "Dart",
                      description:
                          "This text was passed from HomeScreen.",
                    ),
                  ),
                );
              },

              child: const Text(
                "Open Dart Details",
              ),
            ),
          ],
        ),
      ),
    );
  }
}