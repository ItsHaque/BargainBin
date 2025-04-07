import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFC9F1),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF5e35b1)),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Profile Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFc0eeff),
                  const Color(0xFFceffc5).withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Color(0xFF5e35b1),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: Color(0xFF5e35b1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Alex Johnson',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Premium Member • Joined June 2023',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem('24', 'Deals'),
                    _buildStatItem('8', 'Wishlist'),
                    _buildStatItem('4.8', 'Rating'),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _buildProfileCard(
                    icon: Icons.person_outline,
                    title: 'Account Settings',
                    color: const Color(0xFFc0eeff),
                  ),
                  _buildProfileCard(
                    icon: Icons.favorite_border,
                    title: 'Wishlist',
                    color: const Color(0xFFffc9f1),
                  ),
                  _buildProfileCard(
                    icon: Icons.history,
                    title: 'Order History',
                    color: const Color(0xFFceffc5),
                  ),
                  _buildProfileCard(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    color: const Color(0xFFfffbad),
                  ),
                  _buildProfileCard(
                    icon: Icons.help_outline,
                    title: 'Help Center',
                    color: const Color(0xFFc0eeff),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5e35b1),  // Background color
                        foregroundColor: Colors.white,             // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),),  // Rounded corners
                        minimumSize: const Size(double.infinity, 50),  // Full width, 50 height
                        padding: const EdgeInsets.symmetric(vertical: 12),  // Vertical padding
                      ),
                      child: const Text('Sign Out'),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF607D8B),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}