import 'package:flutter/material.dart';
import '../services/car_service.dart';

class MechanicPage extends StatefulWidget {
  final String carId;
  const MechanicPage({super.key, required this.carId});

  @override
  State<MechanicPage> createState() => _MechanicPageState();
}

class _MechanicPageState extends State<MechanicPage> {
  final CarService carService = CarService();
  final _visitsController = TextEditingController();

  void _updateVisits() async {
    final visits = int.tryParse(_visitsController.text);
    if (visits == null) return;
    await carService.updateVisits(widget.carId, visits);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Visitas actualizadas')),
    );
    _visitsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mecánico')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _visitsController,
              decoration: const InputDecoration(labelText: 'Visitas al taller'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateVisits,
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
