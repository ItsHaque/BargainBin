class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String sellerName;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.sellerName,
    required this.description,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      imageUrl: map['image_url'],
      price: map['price'].toDouble(),
      sellerName: map['seller_name'],
      description: map['description'],
    );
  }
}
