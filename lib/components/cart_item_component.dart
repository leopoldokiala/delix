import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItemComponent extends StatelessWidget {
  final CartItem cartItem;
  const CartItemComponent(this.cartItem, {super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  cartItem.imageUrl,
                  width: 60,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                cartItem.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Total: R\$ ${cartItem.price.toString()}',
                style: TextStyle(fontSize: 16),
              ),
              trailing: Text(
                '${cartItem.quantity}x',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.add, size: 25),
                  onPressed: () {
                    // lógica para aumentar quantidade

                    cart.itemsCount + 1;
                  },
                ),
                Text(
                  '${cartItem.quantity}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove, size: 25),
                  onPressed: () {},
                ),
                const SizedBox(width: 12),
                TextButton.icon(
                  onPressed: () {
                    // lógica para remover item
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  label: Text(
                    'Remover',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
