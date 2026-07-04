import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
