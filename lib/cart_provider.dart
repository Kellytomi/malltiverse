import 'package:flutter/material.dart';
import 'products.dart';

class CartProvider with ChangeNotifier {
  final Map<Product, int> _cartItems = {};

  Map<Product, int> get cartItems => _cartItems;

  int get totalItems => _cartItems.values.fold(0, (sum, quantity) => sum + quantity);

  void addItemToCart(Product product) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
    } else {
      _cartItems[product] = 1;
    }
    notifyListeners();
  }

  void removeItemFromCart(Product product) {
    if (_cartItems.containsKey(product)) {
      _cartItems.remove(product);
      notifyListeners();
    }
  }

  void incrementQuantity(Product product) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
      notifyListeners();
    }
  }

  void decrementQuantity(Product product) {
    if (_cartItems.containsKey(product) && _cartItems[product]! > 1) {
      _cartItems[product] = _cartItems[product]! - 1;
      notifyListeners();
    } else {
      removeItemFromCart(product);
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
