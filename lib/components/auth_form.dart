import 'package:delix/utils/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../exceptions/auth_exception.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  AuthMode _authMode = AuthMode.login;
  final passwordContronller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final Map<String, String> _authData = {'email': '', 'password': ''};
  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.linear));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.linear));
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  bool _isLogin() {
    return _authMode == AuthMode.login;
  }

  /*
  bool _isSignup() {
    return _authMode == AuthMode.signup;
  }
  */

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.signup;
        _controller?.forward();
      } else {
        _authMode = AuthMode.login;
        _controller?.reverse();
      }
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ocorreu um erro'),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Fechar', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    Auth auth = Provider.of(context, listen: false);
    if (!isValid) {
      return;
    }
    setState(() => _isLoading = true);
    _formKey.currentState?.save();
    try {
      if (_isLogin()) {
        // Login
        await auth.login(_authData['email']!, _authData['password']!);
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(AppRoute.authOrHome);
        }
      } else {
        // Registrar
        await auth.signUp(_authData['email']!, _authData['password']!);
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(AppRoute.authOrHome);
        }
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 350),
        curve: Curves.easeInCirc,
        padding: EdgeInsets.all(8),
        // margin: EdgeInsets.all(8),
        height: _isLogin() ? 330 : 420,
        width: deviceSize.width * 0.90,
        child: Form(
          key: _formKey,
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
                    return 'Email deve conter @';
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
              //if (_isSignup())
              AnimatedContainer(
                constraints: BoxConstraints(
                  minHeight: _isLogin() ? 0 : 60,
                  maxHeight: _isLogin() ? 0 : 120,
                ),
                duration: Duration(milliseconds: 300),
                curve: Curves.linear,
                child: FadeTransition(
                  opacity: _opacityAnimation!,
                  child: SlideTransition(
                    position: _slideAnimation!,
                    child: TextFormField(
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
                      validator: _isLogin()
                          ? null
                          : (pass) {
                              final password = pass ?? '';
                              if (password != passwordContronller.text) {
                                return 'Senhas incompatíveis';
                              }
                              return null;
                            },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      onPressed: _submit,
                      child: Text(
                        _isLogin() ? 'ENTRAR' : 'REGISTRAR',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
              SizedBox(height: 12),
              Flexible(
                child: TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                    _isLogin()
                        ? 'NÃO TEM UMA CONTA? REGISTRE-SE!'
                        : 'JÁ TEM UMA CONTA? FAÇA LOGIN!',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
