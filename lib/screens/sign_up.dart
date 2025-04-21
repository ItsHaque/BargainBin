import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final supabase = Supabase.instance.client;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  DateTime? selectedDOB;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(controller: fullNameController, decoration: const InputDecoration(labelText: "Full Name")),
            TextField(controller: usernameController, decoration: const InputDecoration(labelText: "Username")),
            TextField(
              controller: dobController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Date of Birth"),
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2005),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  selectedDOB = pickedDate;
                  dobController.text = pickedDate.toLocal().toString().split(' ')[0];
                }
              },
            ),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, obscureText: true, decoration: const InputDecoration(labelText: "Password")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async => await signUp(),
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final fullName = fullNameController.text.trim();
    final username = usernameController.text.trim();
    final dob = selectedDOB;

    if (email.isEmpty || password.isEmpty || fullName.isEmpty || username.isEmpty || dob == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    try {
      // Step 1: Create user in Supabase Auth
      final authResponse = await supabase.auth.signUp(email: email, password: password);
      final user = authResponse.user;

      if (user == null) throw 'Sign up failed';

      // Step 2: Insert into profiles table
      await supabase.from('profiles').insert({
        'id': user.id,
        'email': email,
        'full_name': fullName,
        'username': username,
        'dob': dob.toIso8601String(),
        'created_at': DateTime.now().toIso8601String(),
      });

      // Step 3: Ask user to upload or skip profile picture
      promptForProfilePicture(user.id);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $error')));
    }
  }

  void promptForProfilePicture(String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Upload Profile Picture"),
        content: const Text("Would you like to upload a profile picture now?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              pickAndUploadImage(userId);
            },
            child: const Text("Upload"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home'); // Skip and go to home
            },
            child: const Text("Skip for now"),
          ),
        ],
      ),
    );
  }

  Future<void> pickAndUploadImage(String userId) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final file = File(picked.path);
      final fileExt = picked.path.split('.').last;
      final fileName = '${userId}_profile.$fileExt';
      final filePath = 'avatars/$fileName';

      try {
        await supabase.storage.from('avatars').upload(filePath, file, fileOptions: FileOptions(upsert: true));

        final publicUrl = supabase.storage.from('avatars').getPublicUrl(filePath);

        await supabase.from('profiles').update({'avatar_url': publicUrl}).eq('id', userId);

        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image upload failed: $e")));
      }
    }
  }
}
