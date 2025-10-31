import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});
  @override State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final _name = TextEditingController();
  final _model = TextEditingController();
  bool _loading = false;

  Future <void> _save() async {
    setState(() => _loading = true);
    try {
      await ApiService.createCar(_name.text.trim(), _model.text.trim());
      if (context.mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Añadir coche')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: _name, decoration: const InputDecoration(labelText: 'Nombre')),
          TextField(controller: _model, decoration: const InputDecoration(labelText: 'Modelo')),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _save, child: _loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Guardar')),
        ]),
      ),
    );
  }
}