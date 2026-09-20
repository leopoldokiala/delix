import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_route.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CircleAvatar(
                maxRadius: 60,
                //backgroundColor: Theme.of(context).colorScheme.secondary,
                backgroundImage: AssetImage('assets/leo.jpg'),
              ),
            ),
            Text(
              'Leopoldo Kiala',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text('leopoldo@gmail.com', style: TextStyle(fontSize: 16)),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoute.authOrHome);
              },
              leading: Icon(Icons.shop),
              title: Text('Loja', style: TextStyle(fontSize: 18)),
            ),

            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoute.orders);
              },
              leading: Icon(Icons.list),
              title: Text('Pedidos', style: TextStyle(fontSize: 18)),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoute.products);
              },
              leading: Icon(Icons.edit),
              title: Text('Gerenciar Produtos', style: TextStyle(fontSize: 18)),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Provider.of<Auth>(context, listen: false).logout();
                Navigator.of(context).pushReplacementNamed(AppRoute.authOrHome);
              },
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
