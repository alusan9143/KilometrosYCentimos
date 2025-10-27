import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // quita la etiqueta de "debug"
      title: 'Mi Primera App Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int contador = 0;

  void aumentar() {
    setState(() {
      contador++;
    });
  }

  void reiniciar() {
    setState(() {
      contador = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi primera app Flutter 🚀"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Has presionado el botón:",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "$contador",
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: reiniciar,
              icon: const Icon(Icons.refresh),
              label: const Text("Reiniciar"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: aumentar,
        tooltip: 'Aumentar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
