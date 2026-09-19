import 'package:delix/providers/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/app_Drawer.dart';
import '../components/categories_button.dart';
import '../components/product_grid.dart';
import '../providers/cart.dart';
import '../models/category.dart';
import '../models/Product.dart';

enum FilterOptions { all, favorite }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  bool _showFavoriteOnly = false;
  Category? _selectedCategory;
  Product? product;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductList>(context, listen: false)
        .loadProducts()
        .catchError((error) => debugPrint('Erro ao carregar: $error'))
        .then((value) {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        });
    {}
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductList>(context);
    final filteredProducts = products.items.where((prod) {
      final matchesCategory =
          _selectedCategory == null || prod.category == _selectedCategory;
      final query = _searchQuery.trim().toLowerCase();
      final matchesQuery =
          query.isEmpty || prod.name.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
    final Cart cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        title: Text('Delix'),
        actions: [
          PopupMenuButton<FilterOptions>(
            onSelected: (FilterOptions selectedValue) {
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
              Navigator.of(context).pushNamed('/cart', arguments: products);
            },
            icon: cart.itemsCount > 0
                ? Badge.count(
                    count: cart.itemsCount,
                    textColor: Colors.white,

                    child: Icon(
                      Icons.shopping_cart,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                : Icon(
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
              cursorColor: Theme.of(context).colorScheme.secondary,
              decoration: InputDecoration(
                hint: Text('Buscar produtos'),
                hintStyle: TextStyle(fontSize: 12),
                prefixIcon: Icon(Icons.search),
                // contentPadding: EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                CategoriesButton(
                  'Todos',
                  isSelected: _selectedCategory == null,
                  (category) {
                    setState(() {
                      _selectedCategory = null;
                    });
                  },
                ),
                CategoriesButton(
                  'Alimentos',
                  isSelected: _selectedCategory == Category.alimento,
                  (category) {
                    setState(() {
                      _selectedCategory = Category.alimento;
                    });
                  },
                ),
                CategoriesButton(
                  'Refrigerantes',
                  isSelected: _selectedCategory == Category.refrigerante,
                  (category) {
                    setState(() {
                      _selectedCategory = Category.refrigerante;
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    )
                  : RefreshIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                      onRefresh: () =>
                          Provider.of<ProductList>(
                            context,
                            listen: false,
                          ).loadProducts().then((value) {
                            setState(() {
                              _isLoading = false;
                            });
                          }),
                      child: ProductGrid(_showFavoriteOnly, filteredProducts),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /*
  Future<void> _loadProducts() async {
    await Provider.of<ProductList>(context).loadProducts().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }*/
}
