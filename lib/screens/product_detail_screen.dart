import 'package:flutter/material.dart';
import '../providers/product.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route == null) {
      return Scaffold(body: Center(child: Text('Erro de Rota')));
    }
    final Product product = route.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        title: Text(
          'Detalhes do Poduto',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(product.imageUrl, fit: BoxFit.cover),
          ),
          Column(
            mainAxisAlignment: .spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      product.description,
                      style: TextStyle(color: Colors.black54, fontSize: 18),
                    ),
                    Text(
                      'R\$ ${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Adicionar ao Carrinho',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
