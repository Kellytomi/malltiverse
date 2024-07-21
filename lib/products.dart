// product.dart
class Product {
  final String name;
  final String description;
  final String price;
  final int rating;
  final String imagePath;

  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.imagePath,
  });

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
