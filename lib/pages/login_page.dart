import 'package:flutter/material.dart';
import 'package:kilometrosycentimos/services/auth_service.dart'; 
import 'main_wrapper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;
  String? error;

  Future<void> login() async {
  setState(() {
    loading = true;
    error = null;
  });

  try {
    await firebaseAuth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    
    // Navegar manualmente al MainWrapper
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainWrapper()),
        (route) => false,
      );
    }
    
  } catch (e) {
    setState(() => error = e.toString());
  } finally {
    if (mounted) {
      setState(() => loading = false);
    }
  }
}

  Future<void> signup() async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuenta creada. Inicia sesión.')),
      );
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : login,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Entrar'),
            ),
            TextButton(
              onPressed: signup,
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
