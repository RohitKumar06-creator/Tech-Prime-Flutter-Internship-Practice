import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

// ============================================================
// APP
// ============================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ==========================
      // THEME
      // ==========================

      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffF5F7FB),

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),

        textTheme: GoogleFonts.poppinsTextTheme(),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
      ),

      home: const DeveloperDashboard(),
    );
  }
}

// ============================================================
// DASHBOARD
// ============================================================

class DeveloperDashboard extends StatelessWidget {
  const DeveloperDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Dashboard',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),

          const SizedBox(width: 8),
        ],
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {

          // ==================================================
          // RESPONSIVE DESIGN
          // ==================================================

          bool isDesktop = constraints.maxWidth >= 800;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 60 : 20,
              vertical: 20,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                // ==================================================
                // HERO SECTION
                // ==================================================

                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(25),

                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff6C3CE9),
                        Color(0xff3B82F6),
                      ],

                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),

                    borderRadius: BorderRadius.circular(25),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: isDesktop
                      ? Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,

                          children: [
                            _heroText(),

                            _profileIcon(),
                          ],
                        )
                      : Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [
                            _profileIcon(),

                            const SizedBox(height: 20),

                            _heroText(),
                          ],
                        ),
                ),

                const SizedBox(height: 35),

                // ==================================================
                // SECTION TITLE
                // ==================================================

                Text(
                  'My Skills',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 15),

                // ==================================================
                // RESPONSIVE GRID
                // ==================================================

                GridView.count(
                  crossAxisCount: isDesktop ? 4 : 2,

                  shrinkWrap: true,

                  physics:
                      const NeverScrollableScrollPhysics(),

                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,

                  childAspectRatio:
                      isDesktop ? 1.3 : 1.1,

                  children: [

                    _skillCard(
                      icon: Icons.flutter_dash,
                      title: 'Flutter',
                      level: 'Advanced',
                      progress: 0.85,
                    ),

                    _skillCard(
                      icon: Icons.code,
                      title: 'Dart',
                      level: 'Advanced',
                      progress: 0.80,
                    ),

                    _skillCard(
                      icon: Icons.javascript,
                      title: 'JavaScript',
                      level: 'Intermediate',
                      progress: 0.65,
                    ),

                    _skillCard(
                      icon: Icons.storage,
                      title: 'Database',
                      level: 'Intermediate',
                      progress: 0.60,
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // ==================================================
                // PROJECT SECTION
                // ==================================================

                Text(
                  'Recent Project',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 15),

                Container(
                  width: double.infinity,

                  margin: const EdgeInsets.only(bottom: 20),

                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(22),

                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),

                  child: isDesktop
                      ? Row(
                          children: [
                            _projectIcon(),

                            const SizedBox(width: 20),

                            Expanded(
                              child: _projectInfo(),
                            ),

                            _projectButton(),
                          ],
                        )
                      : Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [
                            _projectIcon(),

                            const SizedBox(height: 15),

                            _projectInfo(),

                            const SizedBox(height: 15),

                            _projectButton(),
                          ],
                        ),
                ),

                // ==================================================
                // QUICK STATS
                // ==================================================

                Text(
                  'Quick Stats',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 15),

                Container(
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(22),
                  ),

                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround,

                    children: [

                      _stat(
                        'Projects',
                        '24',
                        Icons.folder_outlined,
                      ),

                      _stat(
                        'Commits',
                        '342',
                        Icons.commit,
                      ),

                      _stat(
                        'Followers',
                        '1.8K',
                        Icons.people_outline,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // HERO TEXT
  // ============================================================

  Widget _heroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(
          'Hello, Developer 👋',
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: 15,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Build something\nawesome today.',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 15),

        Text(
          'Keep learning. Keep building.',
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PROFILE ICON
  // ============================================================

  Widget _profileIcon() {
    return Container(
      width: 80,
      height: 80,

      alignment: Alignment.center,

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),

        shape: BoxShape.circle,

        border: Border.all(
          color: Colors.white.withOpacity(0.4),
          width: 2,
        ),
      ),

      child: const Icon(
        Icons.person,
        size: 45,
        color: Colors.white,
      ),
    );
  }

  // ============================================================
  // SKILL CARD
  // ============================================================

  Widget _skillCard({
    required IconData icon,
    required String title,
    required String level,
    required double progress,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,

              borderRadius:
                  BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: Colors.deepPurple,
              size: 28,
            ),
          ),

          const Spacer(),

          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),

          Text(
            level,
            style: GoogleFonts.poppins(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 8),

          ClipRRect(
            borderRadius:
                BorderRadius.circular(10),

            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PROJECT ICON
  // ============================================================

  Widget _projectIcon() {
    return Container(
      width: 70,
      height: 70,

      alignment: Alignment.center,

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Colors.deepPurple,
            Colors.blue,
          ],
        ),

        borderRadius:
            BorderRadius.circular(18),
      ),

      child: const Icon(
        Icons.phone_android,
        color: Colors.white,
        size: 35,
      ),
    );
  }

  // ============================================================
  // PROJECT INFO
  // ============================================================

  Widget _projectInfo() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Text(
          'Mobile Expense Tracker',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          'A Flutter app for managing daily expenses, '
          'budgets and financial goals.',
          style: GoogleFonts.poppins(
            color: Colors.grey,
            fontSize: 13,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 10),

        Wrap(
          spacing: 8,

          children: [
            _tag('Flutter'),
            _tag('Firebase'),
            _tag('Dart'),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // PROJECT BUTTON
  // ============================================================

  Widget _projectButton() {
    return ElevatedButton.icon(
      onPressed: () {},

      icon: const Icon(Icons.arrow_forward),

      label: const Text('View'),

      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),

        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
      ),
    );
  }

  // ============================================================
  // TAG
  // ============================================================

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: Colors.grey.shade100,

        borderRadius:
            BorderRadius.circular(20),
      ),

      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ============================================================
  // STAT
  // ============================================================

  Widget _stat(
    String title,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [

        Icon(
          icon,
          color: Colors.deepPurple,
          size: 28,
        ),

        const SizedBox(height: 7),

        Text(
          value,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),

        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}