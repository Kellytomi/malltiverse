import 'package:flutter/material.dart';
import 'products.dart';  // Ensure this import path is correct

class SavedItemsProvider with ChangeNotifier {
  final List<Product> _savedItems = [];

  List<Product> get savedItems => _savedItems;

  void addItemToSaved(Product product) {
    _savedItems.add(product);
    notifyListeners();
  }

  void removeItemFromSaved(Product product) {
    _savedItems.remove(product);
    notifyListeners();
  }

  bool isSaved(Product product) {
    return _savedItems.contains(product);
  }
}
