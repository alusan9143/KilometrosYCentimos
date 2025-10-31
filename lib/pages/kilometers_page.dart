import 'package:flutter/material.dart';
import '../services/car_service.dart';

class KilometersPage extends StatefulWidget {
  final String carId;
  const KilometersPage({super.key, required this.carId});

  @override
  State<KilometersPage> createState() => _KilometersPageState();
}

class _KilometersPageState extends State<KilometersPage> {
  final CarService carService = CarService();
  final _kmController = TextEditingController();

  void _updateKm() async {
    final kms = int.tryParse(_kmController.text);
    if (kms == null) return;
    await carService.updateKilometers(widget.carId, kms);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kilómetros actualizados')),
    );
    _kmController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kilómetros')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _kmController,
              decoration: const InputDecoration(labelText: 'Kilómetros actuales'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateKm,
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
