class Product {
  final String name;
  final String description;
  final String price;
  final int rating;
  final String imagePath;
  final String category;

  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.imagePath,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    String imagePath = '';
    if (json['photos'] != null && json['photos'].isNotEmpty) {
      final photo = json['photos'][0];
      if (photo != null && photo['url'] != null) {
        imagePath = 'https://api.timbu.cloud/images/${photo['url']}';
      }
    }

    return Product(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: '₦${json['current_price'][0]['NGN'][0]}',
      rating: json['rating'] ?? 0,
      category: json['categories'][0]['name'] ?? 'Unknown',
      imagePath: imagePath.isEmpty ? 'assets/images/default_product_image.png' : imagePath,  // Use a default image if imagePath is empty
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.rating == rating &&
        other.imagePath == imagePath;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        rating.hashCode ^
        imagePath.hashCode;
  }
}
