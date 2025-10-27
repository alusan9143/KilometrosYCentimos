import 'package:flutter/material.dart';
import '../services/api_service.dart';

class FuelPage extends StatefulWidget {
  final String carId;
  const FuelPage({super.key, required this.carId});

  @override
  State<FuelPage> createState() => _FuelPageState();
}

class _FuelPageState extends State<FuelPage> {
  final _controller = TextEditingController();

  Future<void> _save() async {
    final fuel = double.tryParse(_controller.text);
    if (fuel == null) return;
    await ApiService.updateFuel(widget.carId, fuel);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Actualizar Combustible')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Litros de combustible'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _save, child: const Text('Guardar')),
        ]),
      ),
    );
  }
}
