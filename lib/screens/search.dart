import 'package:flutter/material.dart';

class Search extends StatefulWidget{
  const Search({super.key});

  @override
  State<Search> createState()=> _SearchState();
}

class _SearchState extends State<Search>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Search"),),
        backgroundColor: const Color(0xFFFFC9F1),
      ),
      backgroundColor: const Color(0x99FFFFFF),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Color(0xFF5e35b1)),
                  hintText: 'Find amazing deals...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategoryChip('Electronics', const Color(0xFFc0eeff)),
                _buildCategoryChip('Clothing', const Color(0xFFceffc5)),
                _buildCategoryChip('Home', const Color(0xFFffc9f1)),
                _buildCategoryChip('Sports', const Color(0xFFffcaca)),
                _buildCategoryChip('Books', const Color(0xFFceffc5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildCategoryChip(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

