import '../providers/product.dart';
import '../providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;
  final List<Product> filterProducts;
  const ProductGrid(this.showFavoriteOnly, this.filterProducts, {super.key});

  @override
  Widget build(BuildContext context) {
    final products = showFavoriteOnly
        ? filterProducts.where((prod) => prod.isFavorite).toList()
        : filterProducts;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        );
      },
    );
  }
}
