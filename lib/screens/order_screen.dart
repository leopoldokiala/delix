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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<OrderList>(context, listen: false).loadOrders().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _refreshOrders() async {
    await Provider.of<OrderList>(context, listen: false).loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderList>(context);
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            )
          : RefreshIndicator(
              color: Theme.of(context).colorScheme.secondary,
              onRefresh: () => _refreshOrders(),
              child: ListView.builder(
                itemCount: orders.itemCount,
                itemBuilder: (context, index) {
                  return OrderComponent(orders.items[index]);
                },
              ),
            ),
    );
  }
}
