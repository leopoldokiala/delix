import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/app_Drawer.dart';
import '../providers/order_list.dart';
import '../components/order_component.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: Provider.of<OrderList>(context, listen: false).loadOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
          } else if (snapshot.error != null) {
            return Center(
              child: Text(
                'Erro ao trazer os dados!',
                style: TextStyle(color: Colors.black),
              ),
            );
          } else {
            return Consumer<OrderList>(
              builder: (context, orders, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return OrderComponent(orders.items[index]);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
