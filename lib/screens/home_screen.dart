import 'package:delix/providers/products.dart';
import 'package:delix/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/app_Drawer.dart';
import '../components/categories_button.dart';
import '../components/product_grid.dart';

enum FilterOptions { all, favorite }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showFavoriteOnly = false;
  String _selectedCategory = 'Todos';
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    final filteredProducts = _selectedCategory == 'Todos'
        ? products.items
        : products.items
              .where((prod) => prod.category == _selectedCategory)
              .toList();
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        title: Text(
          'Delix',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 24,
          ),
        ),
        actions: [
          PopupMenuButton<FilterOptions>(
            onSelected: (FilterOptions selectedValue) {
              debugPrint('Valor: $selectedValue');
              if (selectedValue == FilterOptions.favorite) {
                setState(() {
                  _showFavoriteOnly = true;
                });
              } else {
                setState(() {
                  _showFavoriteOnly = false;
                });
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Somente Favoritos'),
              ),
              PopupMenuItem(value: FilterOptions.all, child: Text('Todos')),
            ],
          ),

          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return CartScreen();
                  },
                ),
              );
            },
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
                CategoriesButton(
                  'Todos',
                  isSelected: _selectedCategory == 'Todos',
                  (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
                CategoriesButton(
                  'Alimentos',
                  isSelected: _selectedCategory == 'Alimentos',
                  (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
                CategoriesButton(
                  'Refrigerantes',
                  isSelected: _selectedCategory == 'Refrigerantes',
                  (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
              ],
            ),
            Expanded(child: ProductGrid(_showFavoriteOnly, filteredProducts)),
          ],
        ),
      ),
    );
  }
}
