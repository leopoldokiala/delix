import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/dummy_data.dart';
import '../components/product_item.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> product = dummyData;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: product.length,
      itemBuilder: (context, index) {
        return ProductItem(product[index]);
      },
    );
  }
}
