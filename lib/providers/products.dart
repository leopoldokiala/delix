import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/dummy_data.dart';

class Products with ChangeNotifier {
  final List<Product> _items = dummyData;

  List<Product> get items {
    return [..._items];
  }

  void favoriteItems() {
    items.where((prod) {
      return prod.isFavorite;
    }).toList();
  }
}
