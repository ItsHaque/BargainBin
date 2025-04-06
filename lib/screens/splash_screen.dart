import 'package:bargain_bin/base/navigation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Navigation()), // Navigate to Home
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFC9F1),
      body: SizedBox.expand( // Ensures full screen coverage
        child: Image.asset(
          'assets/BargainBinSplashScreen.png',
          fit: BoxFit.cover, // This makes the image fill the screen
        ),
      ),
    );
  }
}

 