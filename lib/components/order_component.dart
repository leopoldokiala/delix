import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/order.dart';

class OrderComponent extends StatelessWidget {
  final Order order;
  const OrderComponent(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: ListTile(
        title: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Expanded(
              child: Text(
                '#ORD-${order.id}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              '${order.total.toString()} Kz',
              style: TextStyle(fontWeight: .bold, fontSize: 16),
            ),
          ],
        ),
        subtitle: Text(
          DateFormat('dd/MM/yyy hh:mm').format(order.date),
          style: TextStyle(),
        ),
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.expand_more)),
      ),
    );
  }
}
