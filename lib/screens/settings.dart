import 'package:flutter/material.dart';

class Settings extends StatefulWidget{
  const Settings({super.key});

  @override
  State<Settings> createState()=> _SettingsState();
}

class _SettingsState extends State<Settings>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Profile"),),
        backgroundColor: const Color(0xFFFFC9F1),
      ),
      backgroundColor: const Color(0x99FFFFFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Account Section
            _buildSectionHeader('ACCOUNT'),
            _buildSettingsCard(
              icon: Icons.person,
              iconColor: const Color(0xFFffc9f1), // Pastel pink
              title: 'Edit Profile',
              trailing: Icon(Icons.chevron_right),
            ),
            _buildSettingsCard(
              icon: Icons.email,
              iconColor: const Color(0xFFc0eeff), // Pastel blue
              title: 'Change Email',
              trailing: Icon(Icons.chevron_right),
            ),
            _buildSettingsCard(
              icon: Icons.lock,
              iconColor: const Color(0xFFceffc5), // Pastel mint
              title: 'Change Password',
              trailing: Icon(Icons.chevron_right),
            ),
            _buildSectionHeader('APP PREFERENCES'),
            _buildSettingsCard(
              icon: Icons.color_lens,
              iconColor: const Color(0xFFffc9f1), // Pastel pink
              title: 'Theme',
              trailing: Icon(Icons.chevron_right),
            ),
            _buildSettingsCard(
              icon: Icons.notifications,
              iconColor: const Color(0xFFc0eeff), // Pastel blue
              title: 'Notifications',
              trailing: Switch(value: true, onChanged: (bool value) {}),
            ),
            _buildSettingsCard(
              icon: Icons.language,
              iconColor: const Color(0xFFceffc5), // Pastel mint
              title: 'Language',
              subtitle: 'English (US)',
              trailing: Icon(Icons.chevron_right),
            ),

            // Support
            _buildSectionHeader('SUPPORT'),
            _buildSettingsCard(
              icon: Icons.help,
              iconColor: const Color(0xFFffc9f1), // Pastel pink
              title: 'Help Center',
              trailing: Icon(Icons.chevron_right),
            ),
            _buildSettingsCard(
              icon: Icons.feedback,
              iconColor: const Color(0xFFc0eeff), // Pastel blue
              title: 'Send Feedback',
              trailing: Icon(Icons.chevron_right),
            ),
            _buildSettingsCard(
              icon: Icons.star,
              iconColor: const Color(0xFFceffc5), // Pastel mint
              title: 'Rate BargainBin',
              trailing: Icon(Icons.chevron_right),
            ),
            _buildSectionHeader('LEGAL'),
            _buildSettingsCard(
              icon: Icons.privacy_tip,
              iconColor: const Color(0xFFffc9f1), // Pastel pink
              title: 'Privacy Policy',
              trailing: Icon(Icons.chevron_right),
            ),
            _buildSettingsCard(
              icon: Icons.description,
              iconColor: const Color(0xFFc0eeff), // Pastel blue
              title: 'Terms of Service',
              trailing: Icon(Icons.chevron_right),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5e35b1), // Dark purple
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: const Color(0xFF5e35b1), // Dark purple
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

Widget _buildSettingsCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    required Widget trailing,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF5e35b1)), // Dark purple icon
        ),
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: trailing,
        onTap: () {},
      ),
    );
  }
