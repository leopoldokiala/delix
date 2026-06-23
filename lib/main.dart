import 'package:cardapio_online/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/home_screen.dart';

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
