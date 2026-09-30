import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_route.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);
    Future<void> confirmLogOut() {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              'Tem a certeza que quer sair?',
              style: TextStyle(fontSize: 18),
            ),
            title: Text('Sair'),
            actions: [
              TextButton(
                onPressed: () {
                  auth.logout();
                  Navigator.of(context).pop();
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(AppRoute.authOrHome);
                },
                child: Text(
                  'Sim',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Não',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

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
                backgroundImage: AssetImage('assets/images/leo.jpg'),
              ),
            ),
            Text(
              'Leopoldo Kiala',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              auth.isAuth ? auth.email.toString() : 'Email',
              style: TextStyle(fontSize: 16),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoute.authOrHome);
              },
              leading: Icon(
                Icons.shop,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text('Loja', style: TextStyle(fontSize: 18)),
            ),

            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoute.orders);
              },
              leading: Icon(
                Icons.list,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text('Pedidos', style: TextStyle(fontSize: 18)),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoute.products);
              },
              leading: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text('Gerenciar Produtos', style: TextStyle(fontSize: 18)),
            ),
            Divider(),
            ListTile(
              onTap: () => confirmLogOut(),
              leading: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text('Sair', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
