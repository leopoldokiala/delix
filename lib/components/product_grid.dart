import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/dummy_data.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> product = dummyData;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: product.length,
      itemBuilder: (context, index) {
        return Text(product[index].title);
      },
    );
  }
}
