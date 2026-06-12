import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: SizedBox(
                height: 130,
                width: double.infinity,
                child: Image.network(product.imageUrl, fit: BoxFit.cover),
              ),
            ),
          ),
          Text(
            product.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            product.description,
            style: TextStyle(fontSize: 13),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                Text(
                  'R\$ ${product.price.toString()}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(16),
                          border: Border.all(),
                        ),
                        child: Icon(Icons.add, color: Colors.brown),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
