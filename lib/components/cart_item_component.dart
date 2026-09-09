import 'package:delix/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cartItem.dart';
import '../providers/cart.dart';

class CartItemComponent extends StatelessWidget {
  final CartItem cartItem;
  const CartItemComponent(this.cartItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              title: Text(
                cartItem.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Total: ${CurrencyFormatter.formatPrice(cartItem.price)} kz',
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
                const SizedBox(width: 12),
                TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Tem a certeza?'),
                          content: Text(
                            'Remover Produto do carrinho',
                            style: TextStyle(fontSize: 18),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Provider.of<Cart>(
                                  context,
                                  listen: false,
                                ).removeItem(cartItem.productId);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Sim',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancelar',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
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
