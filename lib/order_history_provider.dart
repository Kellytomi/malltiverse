import 'package:flutter/material.dart';
import 'products.dart';

class OrderHistoryProvider with ChangeNotifier {
  final List<Product> _orders = [];

  List<Product> get orders => List.unmodifiable(_orders);

  void addOrder(List<Product> products) {
    _orders.addAll(products);
    notifyListeners();
  }
}
