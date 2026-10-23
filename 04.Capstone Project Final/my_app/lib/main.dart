import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import './core/constants/utils/db_seeder.dart';
import 'firebase_options.dart';
import 'features/splash/splash_screen.dart';
import 'features/profile/viewmodels/profile_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // await seedFirestoreData();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProfileViewModel())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecare Healthcare App',
      theme: ThemeData(
        fontFamily:
            'Montserrat', // Sets Montserrat across the entire application
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}
