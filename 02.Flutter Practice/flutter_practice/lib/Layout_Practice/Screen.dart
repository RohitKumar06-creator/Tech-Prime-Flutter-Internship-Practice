import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutPractice(),
    ),
  );
}

class LayoutPractice extends StatefulWidget {
  const LayoutPractice({super.key});

  @override
  State<LayoutPractice> createState() => _LayoutPracticeState();
}

class _LayoutPracticeState extends State<LayoutPractice> {
  Alignment selectedAlignment = Alignment.center;

  void changeAlignment(Alignment alignment) {
    setState(() {
      selectedAlignment = alignment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      // --------------------------------------------------
      // APP BAR
      // --------------------------------------------------

      appBar: AppBar(
        title: const Text(
          'Flutter Layout Lab',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      // --------------------------------------------------
      // MAIN LIST
      // --------------------------------------------------

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          // ==================================================
          // HEADER
          // ==================================================

          Container(
            padding: const EdgeInsets.all(24),

            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.deepPurple,
                  Colors.blue,
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),

            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Icon(
                  Icons.dashboard_customize,
                  color: Colors.white,
                  size: 45,
                ),

                SizedBox(height: 15),

                Text(
                  'Layout Practice Lab',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  'Learn how Padding, Margin and Alignment '
                  'control the appearance of your Flutter UI.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // ==================================================
          // 1. PADDING
          // ==================================================

          const Text(
            '01  Padding',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Padding creates space INSIDE a widget.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),

                  child: Image.network(
                    'https://images.unsplash.com/photo-1517336714739-489689fd1ca8',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'MacBook Pro',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Powerful laptop for developers and creators.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(
                      '\$1,299',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {},

                      child: const Text(
                        'Buy Now',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 35),

          // ==================================================
          // 2. MARGIN
          // ==================================================

          const Text(
            '02  Margin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Margin creates space OUTSIDE a widget.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 15),

          // First card
          Container(
            margin: const EdgeInsets.only(bottom: 12),

            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),

            child: const Row(
              children: [

                CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xffE8E0FF),
                  child: Icon(
                    Icons.code,
                    color: Colors.deepPurple,
                  ),
                ),

                SizedBox(width: 15),

                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Flutter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Mobile Development',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Second card
          Container(
            margin: const EdgeInsets.only(bottom: 12),

            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),

            child: const Row(
              children: [

                CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xffE0F2FF),
                  child: Icon(
                    Icons.storage,
                    color: Colors.blue,
                  ),
                ),

                SizedBox(width: 15),

                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      'MongoDB',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Database',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Third card
          Container(
            margin: const EdgeInsets.only(bottom: 12),

            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),

            child: const Row(
              children: [

                CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xffE2FFE8),
                  child: Icon(
                    Icons.api,
                    color: Colors.green,
                  ),
                ),

                SizedBox(width: 15),

                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Node.js',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Backend Development',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ==================================================
          // 3. ALIGNMENT
          // ==================================================

          const Text(
            '03  Alignment',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Alignment controls WHERE a child is positioned.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 15),

          // Alignment playground
          Container(
            height: 260,

            padding: const EdgeInsets.all(15),

            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xff171A35),
                  Color(0xff252A55),
                ],
              ),
              borderRadius: BorderRadius.circular(22),
            ),

            child: Align(
              alignment: selectedAlignment,

              child: Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),

                child: const Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [

                    Icon(
                      Icons.flutter_dash,
                      color: Colors.blue,
                      size: 40,
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Flutter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'Tap a position:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 10),

          // ==================================================
          // ALIGNMENT CONTROLS
          // ==================================================

          GridView.count(
            crossAxisCount: 3,

            shrinkWrap: true,

            physics: const NeverScrollableScrollPhysics(),

            crossAxisSpacing: 10,
            mainAxisSpacing: 10,

            children: [

              _alignmentButton(
                'Top Left',
                Alignment.topLeft,
              ),

              _alignmentButton(
                'Top Center',
                Alignment.topCenter,
              ),

              _alignmentButton(
                'Top Right',
                Alignment.topRight,
              ),

              _alignmentButton(
                'Center Left',
                Alignment.centerLeft,
              ),

              _alignmentButton(
                'Center',
                Alignment.center,
              ),

              _alignmentButton(
                'Center Right',
                Alignment.centerRight,
              ),

              _alignmentButton(
                'Bottom Left',
                Alignment.bottomLeft,
              ),

              _alignmentButton(
                'Bottom Center',
                Alignment.bottomCenter,
              ),

              _alignmentButton(
                'Bottom Right',
                Alignment.bottomRight,
              ),
            ],
          ),

          const SizedBox(height: 30),

          // ==================================================
          // SUMMARY
          // ==================================================

          Container(
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(20),
            ),

            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  'Remember',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  'Padding → Space inside a widget\n\n'
                  'Margin → Space outside a widget\n\n'
                  'Alignment → Position of a child inside its parent',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ==================================================
  // ALIGNMENT BUTTON
  // ==================================================

  Widget _alignmentButton(
    String title,
    Alignment alignment,
  ) {
    final bool isSelected =
        selectedAlignment == alignment;

    return GestureDetector(
      onTap: () {
        changeAlignment(alignment);
      },

      child: Container(
        alignment: Alignment.center,

        padding: const EdgeInsets.all(8),

        decoration: BoxDecoration(
          color: isSelected
              ? Colors.deepPurple
              : Colors.white,

          borderRadius: BorderRadius.circular(12),

          border: Border.all(
            color: isSelected
                ? Colors.deepPurple
                : Colors.grey.shade300,
          ),
        ),

        child: Text(
          title,
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,

            color: isSelected
                ? Colors.white
                : Colors.black87,
          ),
        ),
      ),
    );
  }
}