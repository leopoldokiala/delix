import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/app_Drawer.dart';
import '../providers/order.dart';
import '../components/order_component.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        title: Text(
          'Meus pedidos',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 24,
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemCount,
        itemBuilder: (context, index) {
          return OrderComponent(orders.items[index]);
        },
      ),
    );
  }
}
