import 'package:flutter/material.dart';
import 'package:bargain_bin/models/prodact.dart';

class ProductDetailScreen extends StatelessWidget{
  final Product product;

  const ProductDetailScreen({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: const Color(0xFFFFC9F1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.imageUrl,
              height: 200,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(height: 16,),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8,),
            Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, color: Colors.deepPurple)),
            const SizedBox(height: 16),
            Text('Seller: ${product.sellerName}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Text(product.description),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Add to Cart"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Buy Now"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}