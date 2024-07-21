import 'package:flutter/material.dart';
import '../models/products.dart'; // Ensure this imports the updated Product class

class OrderHistoryProvider with ChangeNotifier {
  List<Product> _orders = [];

  List<Product> get orders => _orders;

  void addOrder(List<Product> products) {
    _orders.addAll(products);
    notifyListeners();
  }

  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}
