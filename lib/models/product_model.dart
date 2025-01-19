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
  // Create a copy of Product with updated fields
  Product copyWith({
    String? id,
    double? price,
    String? imageUrl,
  }) {
    return Product(
      id: id ?? this.id,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
} 