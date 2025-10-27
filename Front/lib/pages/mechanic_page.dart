import 'package:flutter/material.dart';
import '../services/api_service.dart';

class MechanicPage extends StatefulWidget {
  final String carId;
  const MechanicPage({super.key, required this.carId});

  @override
  State<MechanicPage> createState() => _MechanicPageState();
}

class _MechanicPageState extends State<MechanicPage> {
  final _controller = TextEditingController();

  Future<void> _save() async {
    final visits = int.tryParse(_controller.text);
    if (visits == null) return;
    await ApiService.updateVisits(widget.carId, visits);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Actualizar Visitas al Taller')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Número de visitas'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _save, child: const Text('Guardar')),
        ]),
      ),
    );
  }
}
