import 'package:flutter/material.dart';
import 'main_wrapper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userCtrl = TextEditingController();
    final TextEditingController passCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userCtrl,
              decoration: const InputDecoration(labelText: "Usuario"),
            ),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Contraseña"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí podrías validar usuario/contraseña
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const MainWrapper()),
                );
              },
              child: const Text("Entrar"),
            ),
          ],
        ),
      ),
    );
  }
}
