import 'package:cardapio_online/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './components/categories_button.dart';
import 'components/app_drawer.dart';
import './components/product_grid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Products())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            centerTitle: true,
            titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          colorScheme: .fromSeed(
            seedColor: Colors.grey.shade200,
            primary: Color(0xffffab69),
            secondary: Color(0xffb21029),
          ),
          primaryColor: Color(0xffffab69),
          scaffoldBackgroundColor: Color(0xfffef7ff),
          //Colors.grey[200],
          fontFamily: 'Lato',
        ),
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          'Cardápio Online',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            Text(
              'Bem vindo, Usuário',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hint: Text('Buscar pratos ou bebidas'),
                hintStyle: TextStyle(fontSize: 12),
                prefixIcon: Icon(Icons.search),
                // contentPadding: EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                CategoriesButton('Todos'),
                CategoriesButton('Alimentos'),
                CategoriesButton('Refrigerantes'),
              ],
            ),
            Expanded(child: ProductGrid()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        elevation: 5,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'início'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Meus Pedidos',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Meu Carrinho',
          ),
        ],
      ),
    );
  }
}
