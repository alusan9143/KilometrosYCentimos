import 'package:flutter/material.dart';
import '../services/api_service.dart';

class KilometersPage extends StatefulWidget {
  final String carId;
  const KilometersPage({super.key, required this.carId});

  @override
  State<KilometersPage> createState() => _KilometersPageState();
}

class _KilometersPageState extends State<KilometersPage> {
  final _controller = TextEditingController();

  Future<void> _save() async {
    final kms = int.tryParse(_controller.text);
    if (kms == null) return;
    await ApiService.updateKilometers(widget.carId, kms);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Actualizar Kilómetros')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Nuevo kilometraje'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _save, child: const Text('Guardar')),
        ]),
      ),
    );
  }
}
