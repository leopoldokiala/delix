import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  static const _key = 'AIzaSyAIR86y8-y3hYRFYn3-KnbpZaplkag2utY';

  Future<void> _autenticate(
    String email,
    String password,
    String urlFragment,
  ) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=$_key';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    debugPrint('Resposta: ${response.body}');

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    }

    debugPrint('O tipo de erro: ${body.runtimeType.toString()}');
  }

  Future<void> signUp(String email, String password) async {
    return _autenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _autenticate(email, password, 'signInWithPassword');
  }
}
