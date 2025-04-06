import 'package:flutter/material.dart';

class Profile extends StatefulWidget{
  const Profile({super.key});

  @override
  State<Profile> createState()=> _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Profile"),),
        backgroundColor: const Color(0xFFFFC9F1),
      ),
      backgroundColor: const Color(0x99FFFFFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFc0eeff), // Pastel blue
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Profile Picture
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Color(0xFF5e35b1), // Dark purple
                    ),
                  ),
                  const SizedBox(height: 15),
                  // User Name
                  const Text(
                    'Alex Johnson',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Member Since
                  Text(
                    'Member since June 2023',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Member Since
                  Text(
                    'Member since June 2023',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
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