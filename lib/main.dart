import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xfffef7ff),
          centerTitle: true,
        ),
        colorScheme: .fromSeed(
          seedColor: Colors.white70,
          primary: Color(0xfffef7ff),
          secondary: Color(0xffb21029),
        ),
        scaffoldBackgroundColor: Colors.grey[200],
        fontFamily: 'Lato',
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Cardápio Online')));
  }
}
