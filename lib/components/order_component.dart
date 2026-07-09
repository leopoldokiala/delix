import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/order.dart';

class OrderComponent extends StatefulWidget {
  final Order order;
  const OrderComponent(this.order, {super.key});

  @override
  State<OrderComponent> createState() => _OrderComponentState();
}

class _OrderComponentState extends State<OrderComponent> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Column(
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '#ORD-${widget.order.id}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  '${widget.order.total.toString()} Kz',
                  style: TextStyle(fontWeight: .bold, fontSize: 18),
                ),
              ],
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyy hh:mm').format(widget.order.date),
              style: TextStyle(),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: _expanded
                  ? Icon(Icons.expand_less_outlined)
                  : Icon(Icons.expand_more),
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: (widget.order.products.length * 25) + 10,
              width: double.infinity,

              child: ListView(
                children: widget.order.products.map((product) {
                  return Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${product.quantity} x ${product.price}',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
