import 'package:flutter/material.dart';
import '../services/car_service.dart';
import '../services/refuel_service.dart';

class FuelPage extends StatefulWidget {
  final String carId;
  const FuelPage({super.key, required this.carId});

  @override
  State<FuelPage> createState() => _FuelPageState();
}

class _FuelPageState extends State<FuelPage> {
  final CarService carService = CarService();
  final RefuelService refuelService = RefuelService();
  final _litersController = TextEditingController();
  final _priceController = TextEditingController();

  void _addRefuel() async {
    final liters = double.tryParse(_litersController.text);
    final price = double.tryParse(_priceController.text);
    if (liters == null || price == null) return;

    await refuelService.addRefuel(widget.carId, liters, price, DateTime.now());
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Repostaje añadido')),
      );
      _litersController.clear();
      _priceController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Repostajes')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _litersController,
              decoration: const InputDecoration(labelText: 'Litros'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addRefuel,
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
