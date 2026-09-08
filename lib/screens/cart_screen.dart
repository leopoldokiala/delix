import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/currency_formatter.dart';
import '../providers/cart.dart';
import '../providers/order_list.dart';
import '../components/cart_item_component.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        title: Text(
          'Meu Carrinho',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 24,
          ),
        ),
      ),

      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text('Total', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 10),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    label: Text(
                      '${CurrencyFormatter.formatPrice(cart.totalAmount)} kz',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  CartButton(cart: cart),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemsCount,
              itemBuilder: (context, index) {
                return CartItemComponent(cartItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartButton extends StatefulWidget {
  final Cart cart;
  const CartButton({required this.cart, super.key});

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          )
        : TextButton(
            onPressed: widget.cart.itemsCount == 0
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await Provider.of<OrderList>(
                      context,
                      listen: false,
                    ).addOrder(widget.cart);

                    widget.cart.clear();
                    setState(() {
                      _isLoading = false;
                    });
                  },
            child: Text(
              'COMPRAR',
              style: TextStyle(
                fontSize: 16,
                color: widget.cart.itemsCount == 0
                    ? Colors.grey
                    : Theme.of(context).colorScheme.secondary,
              ),
            ),
          );
  }
}
