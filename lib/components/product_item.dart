import '../providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../utils/app_route.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);
    final Cart cart = Provider.of<Cart>(context, listen: false);
    return Card(
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(
                            context,
                          ).pushNamed(AppRoute.detail, arguments: product);
                        },
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          shape: BoxShape.rectangle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            product.toggleFavorite();
                          },
                          icon: Consumer<Product>(
                            builder: (context, product, _) => Icon(
                              product.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Color(0xffb21029),
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 2),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.grey[600],
                    height: 1.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'R\$ ${product.price.toStringAsFixed(2)}',
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      padding:
                          EdgeInsets.zero, // remove padding extra do IconButton
                      onPressed: () {
                        cart.addItem(product);
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Theme.of(context).colorScheme.secondary,
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
