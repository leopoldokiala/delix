import 'package:flutter/material.dart';
import '../providers/products.dart';

class Cart extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  void addItem(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeItem(Product product) {
    _items.remove(product);
    notifyListeners();
  }
}
