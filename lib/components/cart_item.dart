import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    if (cart.items.isEmpty) {
      return const Center(child: Text('Seu carrinho está vazio'));
    }

    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) {
        final product = cart.items[index];
        return Card(
          child: Row(
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: Image.network(product.imageUrl, fit: BoxFit.cover),
              ),
            ],
          ),
        );
      },
    );
  }
}
