import 'package:flutter/material.dart';
import 'package:bargain_bin/base/product_service.dart';
import 'package:bargain_bin/models/prodact.dart';
import 'package:bargain_bin/screens/product_detail_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  List<Product> _products = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }
  Future<void> _loadProducts() async {
    final products = await ProductService().fetchProducts();
    setState(() {
      _products = products;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BargainBin"),
        backgroundColor: const Color(0xFFFFC9F1),
      ),
      backgroundColor: const Color(0xFFFDFDFD),
      body: _loading
            ?const Center(child: CircularProgressIndicator(),)
            :SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle(" Top Deals"),
                    _buildHorizontalProductList(_products),
                    
                    _sectionTitle(" New Arrivals"),
                    _buildHorizontalProductList(_products.reversed.toList()),
                    
                    _sectionTitle(" For You"),
                    _buildHorizontalProductList(_products.take(4).toList()),

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

  Widget _buildHorizontalProductList(List<Product> products) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product=products[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (_)=>ProductDetailScreen(product: product)),
              );
            },
            child: Container(
              width: 160,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 6,
                    offset: const Offset(2, 2),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      product.imageUrl,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.deepPurple),),
                  )
                ],
              ),
            ),
          );
        },
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
