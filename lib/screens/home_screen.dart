import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home"),),
        backgroundColor: const Color(0xFFFFC9F1),
      ),
      backgroundColor: const Color(0x99FFFFFF),
      body: Center(
        child: const Text(
          'Welcome to BargainBin!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

