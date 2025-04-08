import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final SupabaseClient _supabase=Supabase.instance.client;
  Map<String,dynamic>? _userProfile;
  bool _isLoading=true;

  @override
  void initState(){
    super.initState();
    _fetcthUserProfile();
  }

  Future<void> _fetcthUserProfile() async{
    try{
      final user= _supabase.auth.currentUser;
      if(user !=null){
        final response =await _supabase
          .from('profiles')
          .select()
          .eq('id',user.id)
          .single();
        setState(() {
          _userProfile=response;
          _isLoading=false;
        });
      } else{
        setState(()=> _isLoading=false);
      }
    }catch(e){
      setState(()=> _isLoading=false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching profile: ${e.toString()}')),
      );
    }
  }

  Future<void> _signout() async{
    try{
      await _supabase.auth.signOut();
      if(!mounted) return;
      Navigator.pushReplacementNamed(context, '/auth');
    } catch(e){
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sigining out: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if(_isLoading){
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if(_supabase.auth.currentUser==null){
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Looks like you are not signed in',
                style: TextStyle(
                  color: Color(0x89000000),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20,),
              const Text('Already registered?',
                style: TextStyle(
                  color: Color(0x89000000),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5,),
              ElevatedButton(
                onPressed:()=> Navigator.pushNamed(context, '/auth'),
                style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF35A2B1),  
                        foregroundColor: const Color(0xFFFFFFFF),             // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),),  
                        minimumSize: const Size(200, 50),  
                        padding: const EdgeInsets.symmetric(vertical: 12),  
                ),
                child: const Text(
                    'Sign in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
              ),
              const SizedBox(height: 20,),
              const Text('Don\'t have an account?',
                style: TextStyle(
                  color: Color(0x89000000),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5,),
              ElevatedButton(
                onPressed:()=> Navigator.pushNamed(context, '/auth'),
                style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5E35B1),  // Background color
                        foregroundColor: const Color(0xFFFFFFFF),             // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),),  // Rounded corners
                        minimumSize: const Size(200, 50),  // Full width, 50 height
                        padding: const EdgeInsets.symmetric(vertical: 12),  // Vertical padding
                ),
                child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFC9F1),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF5e35b1)),
            onPressed: () =>Navigator.pushNamed(context, '/edit-profile'),
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
                  const Color(0xFFC0EEFF),
                  const Color(0xFFCEFFC5),
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
                  color: const Color(0xFF000000),
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
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: _userProfile?['avatar_url']!=null
                        ?NetworkImage(_userProfile!['avatar_url'])
                        :null,
                      child: _userProfile?['avatar_url']==null
                        ? const Icon(Icons.person, size: 50, color:  Color(0xFF5E35B1))
                        : null,
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
                        color: Color(0xFF5E35B1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  _userProfile?['full_name'] ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Member since ${_userProfile?['created_at']?.split('T')[0] ?? 'Unknown'}',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem(
                      _userProfile?['deals_count']?.toString() ?? '0',
                      'Deals',
                    ),
                    _buildStatItem(
                      _userProfile?['wishlist_count']?.toString() ?? '0',
                      'Wishlist',
                    ),
                    _buildStatItem(
                      _userProfile?['rating']?.toString() ?? '0',
                      'Rating',
                    ),
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
                      onPressed: _signout,
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