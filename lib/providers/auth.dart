import 'dart:async';
import 'dart:convert';

import 'package:delix/data/store.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  static const _key = 'AIzaSyAIR86y8-y3hYRFYn3-KnbpZaplkag2utY';
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expiresDate;
  Timer? _logoutTimer;

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

      try {
        await Store.saveMap('userData', {
          'token': _token,
          'email': _email,
          'userId': _userId,
          'expiresDate': _expiresDate!.toIso8601String(),
        });
        debugPrint('Sessão salva com sucesso');
      } catch (e) {
        debugPrint('ERRO ao salvar sessão: $e');
      }

      _autoLogout();
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    return _autenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _autenticate(email, password, 'signInWithPassword');
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final userData = await Store.getMap('userData');
    if (userData.isEmpty) return;

    try {
      final expiresDate = DateTime.parse(userData['expiresDate']);
      if (expiresDate.isBefore(DateTime.now())) return;

      _token = userData['token'];
      _email = userData['email'];
      _userId = userData['userId'];
      _expiresDate = expiresDate;

      _autoLogout();
      notifyListeners();
    } catch (_) {
      return;
    }
  }

  void logout() {
    _token = null;
    _email = null;
    _userId = null;
    _expiresDate = null;
    _clearLogoutTimer();
    Store.remove('userData').then((_) {
      notifyListeners();
    });
  }

  void _clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void _autoLogout() {
    _clearLogoutTimer();
    final timeToLogout = _expiresDate?.difference(DateTime.now()).inSeconds;
    //debugPrint('Tempo do Token: $timeToLogout');
    _logoutTimer = Timer(Duration(seconds: timeToLogout ?? 0), logout);
  }
}
