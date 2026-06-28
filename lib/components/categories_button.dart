import 'package:flutter/material.dart';

class CategoriesButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function(String) onSelectCategory;

  const CategoriesButton(
    this.text,
    this.onSelectCategory, {
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          isSelected
              ? Theme.of(context).colorScheme.secondary
              : Colors.grey.shade200,
        ),
      ),
      onPressed: () => onSelectCategory(text),
      child: isSelected
          ? Text(text, style: TextStyle(color: Colors.white))
          : Text(text, style: TextStyle(color: Colors.black)),
    );
  }
}
