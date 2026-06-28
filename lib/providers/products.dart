import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class Product extends ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

class Products with ChangeNotifier {
  final List<Product> _items = dummyData;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prod) {
      return prod.isFavorite;
    }).toList();
  }
}
