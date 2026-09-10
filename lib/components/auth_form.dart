import 'package:flutter/material.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final AuthMode _authMode = AuthMode.login;
  final passwordContronller = TextEditingController();
  final Map<String, String> _authData = {'email': '', 'password': ''};

  void _submit() {}
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 320,
        width: deviceSize.width * 0.90,
        child: Form(
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                cursorColor: Theme.of(context).colorScheme.secondary,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (eemail) {
                  final email = eemail ?? '';
                  if (email.isEmpty) {
                    return 'Email não deve ter espaço';
                  }
                  if (!email.contains('@')) {
                    return 'Email não contém @';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordContronller,
                keyboardType: TextInputType.text,
                cursorColor: Theme.of(context).colorScheme.secondary,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                obscureText: true,
                onSaved: (password) => _authData['password'] = password ?? '',
                validator: (pass) {
                  final password = pass ?? '';
                  if (password.isEmpty || password.length < 4) {
                    return 'Informe uma senha válida!';
                  }
                  return null;
                },
              ),
              if (_authMode == AuthMode.signup)
                TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  obscureText: true,
                  validator: _authMode == AuthMode.login
                      ? null
                      : (pass) {
                          final password = pass ?? '';
                          if (password != passwordContronller.text) {
                            return 'Senhas incompatíveis';
                          }
                          return null;
                        },
                ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onPressed: _submit,
                child: Text(
                  _authMode == AuthMode.login ? 'ENTARAR' : 'REGISTRAR',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
