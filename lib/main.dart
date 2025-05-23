import 'package:flutter/material.dart';
import 'package:music/Screens/Login.dart';
import 'package:music/Screens/home.dart';
import 'package:music/Screens/music.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen()
      // MusicScreen(),
      // HomeScreen(),
    );
  }
}


