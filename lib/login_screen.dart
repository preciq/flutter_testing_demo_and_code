// lib/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_testing_demo_and_code/auth_service.dart';

class LoginScreen extends StatefulWidget {
  final AuthService authService;
  const LoginScreen({super.key, required this.authService});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _message; // stores success or error message

  Future<void> _handleLogin() async {
    final user = _usernameController.text;
    final pass = _passwordController.text;
    try {
      bool success = await widget.authService.login(user, pass);
      setState(() {
        _message = success ? 'Welcome, $user!' : 'Login failed';
      });
      // In a real app, you might navigate on success.
    } catch (e) {
      setState(() {
        _message = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              key: Key('usernameField'),
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              key: Key('passwordField'),
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              key: Key('loginButton'),
              onPressed: _handleLogin,
              child: Text('Login'),
            ),
            if (_message != null) // display message if available
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(_message!, key: Key('loginMessage')),
              ),
          ],
        ),
      ),
    );
  }
}
