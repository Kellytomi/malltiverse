// cart_provider.dart
import 'package:flutter/material.dart';
import 'products.dart';

class CartProvider with ChangeNotifier {
  final Map<Product, int> _cartItems = {};

  Map<Product, int> get cartItems => _cartItems;

  void addItemToCart(Product product) {
    print('Adding product: ${product.name}');
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
    } else {
      _cartItems[product] = 1;
    }
    print('Cart items after addition: $_cartItems');
    notifyListeners();
  }

  void removeItemFromCart(Product product) {
    print('Removing product: ${product.name}');
    _cartItems.remove(product);
    print('Cart items after removal: $_cartItems');
    notifyListeners();
  }

  void incrementQuantity(Product product) {
    print('Incrementing quantity for product: ${product.name}');
    _cartItems[product] = _cartItems[product]! + 1;
    print('Cart items after increment: $_cartItems');
    notifyListeners();
  }

  void decrementQuantity(Product product) {
    print('Decrementing quantity for product: ${product.name}');
    if (_cartItems[product] == 1) {
      _cartItems.remove(product);
    } else {
      _cartItems[product] = _cartItems[product]! - 1;
    }
    print('Cart items after decrement: $_cartItems');
    notifyListeners();
  }

  int get totalItems => _cartItems.values.fold(0, (sum, item) => sum + item);

  int getTotalAmount() {
    return _cartItems.entries.fold(0, (sum, entry) {
      return sum + int.parse(entry.key.price.replaceAll(RegExp(r'[^0-9]'), '')) * entry.value;
    });
  }
}
