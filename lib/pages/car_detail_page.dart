import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';

class CarDetailPage extends StatelessWidget {
  final String nombre;
  const CarDetailPage({super.key, required this.nombre});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Detalles del Coche"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Detalles de $nombre",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text("Marca: Desconocida"),
            const Text("Modelo: -"),
            const Text("Año: -"),
            const Text("Kilometraje: -"),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Funcionalidad pendiente")),
                  );
                },
                child: const Text("Editar información"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
