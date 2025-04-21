import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BargainBin"),
        backgroundColor: const Color(0xFFFFC9F1),
      ),
      backgroundColor: const Color(0xFFFDFDFD),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(" Top Deals"),
              _horizontalScrollSection(["Item 1", "Item 2", "Item 3"]),
              
              _sectionTitle(" New Arrivals"),
              _horizontalScrollSection(["New 1", "New 2", "New 3"]),
              
              _sectionTitle(" For You"),
              _forYouGrid(),

              _sectionTitle(" Categories"),
              _categoryDropdown(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _horizontalScrollSection(List<String> items) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFffc9f1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text(items[index])),
          );
        },
      ),
    );
  }

  Widget _forYouGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3 / 2,
        children: List.generate(4, (index) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFFceffc5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text("Recommended ${index + 1}")),
          );
        }),
      ),
    );
  }

  Widget _categoryDropdown() {
    String dropdownValue = 'Electronics'; // default category
    List<String> categories = ['Electronics', 'Fashion', 'Furniture', 'Books'];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButtonFormField<String>(
        value: dropdownValue,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: const Color(0xFFc0eeff),
        ),
        items: categories
            .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ))
            .toList(),
        onChanged: (value) {
          // Later: Trigger filter or navigation
        },
      ),
    );
  }
}
