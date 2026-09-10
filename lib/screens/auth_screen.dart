import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffb21029), Color(0xff3f050f)],
              ),
            ),
          ),
          Container(width: double.infinity, child: Column()),
        ],
      ),
    );
  }
}
