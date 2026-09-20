import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  static const _key = 'AIzaSyAIR86y8-y3hYRFYn3-KnbpZaplkag2utY';
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expiresDate;

  bool get isAuth {
    final isValid = _expiresDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token => isAuth ? _token : null;
  String? get email => isAuth ? _email : null;
  String? get userId => isAuth ? _userId : null;

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
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];
      _expiresDate = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    return _autenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _autenticate(email, password, 'signInWithPassword');
  }
}
