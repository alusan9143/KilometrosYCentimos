import 'package:flutter/material.dart';

class CarDetailPage extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarDetailPage({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(car['name'] ?? 'Coche')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Modelo: ${car['model']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Kilómetros: ${car['kilometers'] ?? 0}'),
            Text('Combustible: ${car['fuel'] ?? 0} L'),
            Text('Visitas al mecánico: ${car['visits'] ?? 0}'),
          ],
        ),
      ),
    );
  }
}
