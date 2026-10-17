import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const KidVerse());
}

class KidVerse extends StatelessWidget {
  const KidVerse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KidVerse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6DD5ED),
          brightness: Brightness.light,
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
