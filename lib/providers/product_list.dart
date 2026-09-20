import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/product.dart';
import '../exceptions/http_exception.dart';
import '../utils/constants.dart';

class ProductList with ChangeNotifier {
  final String _token;
  final String _userId;
  final List<Product> _items;
  ProductList([this._token = '', this._userId = '', List<Product>? items])
    : _items = items ?? [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('${Constants.productBaseUrl}.json?auth=$_token'),
    );

    if (response.statusCode >= 400) {
      throw HttpException(
        msg: 'Não foi possível carregar os produtos',
        statusCode: response.statusCode,
      );
    }

    if (response.body == 'null') {
      notifyListeners();
      return;
    }

    final favoriteResponse = await http.get(
      Uri.parse('${Constants.userFavoritesUrl}/$_userId.json?auth=$_token'),
    );

    Map<String, dynamic> favoriteData = favoriteResponse.body == 'null'
        ? <String, dynamic>{}
        : jsonDecode(favoriteResponse.body) as Map<String, dynamic>;

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      final isFavorite = favoriteData[productId] ?? false;
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite,
          category: Category.values.byName(
            (productData['category'] as String).replaceFirst('Category.', ''),
          ),
        ),
      );
    });
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('${Constants.productBaseUrl}.json?auth=$_token'),
      body: jsonEncode({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'category': (product.category.name).toString(),
      }),
    );

    if (response.statusCode >= 400) {
      _items.add(product);
      notifyListeners();
      throw HttpException(
        msg: 'Não foi possível Adicionar o Produto',
        statusCode: response.statusCode,
      );
    }

    final id = jsonDecode(response.body)['name'];

    _items.add(
      Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        category: product.category,
      ),
    );
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object?> data) {
    bool? hasId = data['id'] != null;
    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'].toString(),
      category: data['category'] as Category,
    );
    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index < 0) return;

    final response = await http.patch(
      Uri.parse('${Constants.productBaseUrl}/${product.id}.json?auth=$_token'),
      body: jsonEncode({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'category': product.category.name,
      }),
    );

    if (response.statusCode >= 400) {
      throw HttpException(
        msg: 'Não foi possível Atualizar o Produto',
        statusCode: response.statusCode,
      );
    }

    product.isFavorite = _items[index].isFavorite;
    _items[index] = product;
    notifyListeners();
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse(
          '${Constants.productBaseUrl}/${product.id}.json?auth=$_token',
        ),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
          msg: 'Não foi possível excluir o Produto',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
