import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isLogin = true;

  Future<void> _submit() async {
    try {
      if (_isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.text.trim(), password: _password.text.trim());
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.text.trim(), password: _password.text.trim());
      }
      // auth state listener in MainWrapper will navigate
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Error')));
    }
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Iniciar sesión' : 'Registro')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
          const SizedBox(height: 8),
          TextField(controller: _password, decoration: const InputDecoration(labelText: 'Contraseña')),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _submit, child: Text(_isLogin ? 'Entrar' : 'Registrarse')),
          TextButton(onPressed: () => setState(() => _isLogin = !_isLogin), child: Text(_isLogin ? 'Crear cuenta' : 'Ya tengo cuenta')),
        ]),
      ),
    );
  }
}