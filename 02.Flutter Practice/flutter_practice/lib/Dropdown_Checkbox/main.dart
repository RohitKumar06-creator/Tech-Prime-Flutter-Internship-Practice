import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PreferencePage(),
    ),
  );
}

class PreferencePage extends StatefulWidget {
  const PreferencePage({super.key});

  @override
  State<PreferencePage> createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {

  String selectedCity = "Islamabad";

  bool flutter = false;
  bool dart = false;
  bool firebase = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Preferences"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Select your city",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // DROPDOWN
            DropdownButton<String>(
              value: selectedCity,

              isExpanded: true,

              items: const [
                DropdownMenuItem(
                  value: "Islamabad",
                  child: Text("Islamabad"),
                ),

                DropdownMenuItem(
                  value: "Lahore",
                  child: Text("Lahore"),
                ),

                DropdownMenuItem(
                  value: "Karachi",
                  child: Text("Karachi"),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  selectedCity = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            const Text(
              "Choose your skills",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            // CHECKBOX
            CheckboxListTile(
              title: const Text("Flutter"),
              value: flutter,

              onChanged: (value) {
                setState(() {
                  flutter = value!;
                });
              },
            ),

            CheckboxListTile(
              title: const Text("Dart"),
              value: dart,

              onChanged: (value) {
                setState(() {
                  dart = value!;
                });
              },
            ),

            CheckboxListTile(
              title: const Text("Firebase"),
              value: firebase,

              onChanged: (value) {
                setState(() {
                  firebase = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            Text(
              "City: $selectedCity",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}