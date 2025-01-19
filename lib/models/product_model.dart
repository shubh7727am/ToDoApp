class Product {
  final String id;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.price, 
    required this.imageUrl
  });

  // Convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  // Create Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }
} 