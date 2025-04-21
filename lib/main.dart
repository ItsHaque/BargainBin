import 'package:bargain_bin/screens/home_screen.dart';
import 'package:bargain_bin/screens/sign_up.dart';
import 'package:bargain_bin/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



const supabaseUrl = 'https://rkvbzbtizljhaqutnirt.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJrdmJ6YnRpemxqaGFxdXRuaXJ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI4MzUyMjAsImV4cCI6MjA1ODQxMTIyMH0.h_qrMGQZo8Mz-Sg728q9Cp43N_f5XtoQO5P4BMWmFHc';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl, 
    anonKey: supabaseKey
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      routes: {
        '/home': (context)=>  HomeScreen(),
        '/signup': (context)=> SignUpPage(),
      },
    );
  }
}
