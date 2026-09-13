import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  static const _key = 'AIzaSyAIR86y8-y3hYRFYn3-KnbpZaplkag2utY';
  static const _urlSignUp =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_key';
  static const _urlSignIn =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_key';

  Future<void> signUp(String email, String password) async {
    final response = await http.post(
      Uri.parse(_urlSignUp),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    debugPrint('Resposta: ${response.body}');
  }

  Future<void> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse(_urlSignIn),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    debugPrint('Resposta: ${response.body}');
  }
}
