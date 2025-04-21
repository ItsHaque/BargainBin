import 'package:bargain_bin/models/prodact.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final supabase = Supabase.instance.client;

  Future<List<Product>> fetchProducts() async {
    final response = await supabase.from('products').select();

    if (response.isEmpty) {
      return [];
    }

    return (response as List).map((item) => Product.fromMap(item)).toList();
  }
}
