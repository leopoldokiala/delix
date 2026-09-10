import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../utils/currency_formatter.dart';
import '../utils/app_route.dart';
import '../providers/product_list.dart';
import '../exceptions/http_exception.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: 90,
            height: 60,
            child: Image.network(product.imageUrl, fit: BoxFit.cover),
          ),
        ),
        title: Text(product.name, style: TextStyle(color: Colors.black)),
        subtitle: Text(
          '${CurrencyFormatter.formatPrice(product.price)} kz',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        trailing: Column(
          mainAxisSize: .min,
          children: [
            Expanded(
              child: IconButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushNamed(AppRoute.productForm, arguments: product);
                },
                icon: Icon(Icons.edit, color: Colors.red.shade600),
              ),
            ),

            Expanded(
              child: IconButton(
                onPressed: () {
                  showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Excluir Produto'),
                        content: const Text(
                          'Tem certeza?',
                          style: TextStyle(fontSize: 18),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text(
                              'Não',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text(
                              'Sim',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    },
                  ).then((value) async {
                    if (value ?? false) {
                      if (!context.mounted) return;
                      try {
                        await Provider.of<ProductList>(
                          context,
                          listen: false,
                        ).removeProduct(product);
                      } on HttpException catch (error) {
                        if (!context.mounted) return;
                        msg.showSnackBar(
                          SnackBar(
                            backgroundColor: Color(0xffb21029),
                            content: Text(error.toString()),
                          ),
                        );
                      }
                    }
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
