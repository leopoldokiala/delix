import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/auth.dart';
import './home_screen.dart';
import '../screens/auth_screen.dart';

class AuthOrHomeScreen extends StatelessWidget {
  const AuthOrHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return auth.isAuth ? HomeScreen() : AuthScreen();
  }
}
