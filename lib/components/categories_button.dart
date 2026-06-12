import 'package:flutter/material.dart';

class CategoriesButton extends StatelessWidget {
  final String text;
  const CategoriesButton(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(text, style: TextStyle(color: Colors.black)),
    );
  }
}
