import 'package:flutter/material.dart';
import '../services/car_service.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _modelController = TextEditingController();
  final CarService carService = CarService();

  void _saveCar() async {
    if (_formKey.currentState!.validate()) {
      await carService.createCar(
        _nameController.text,
        _modelController.text,
      );
      if (mounted) Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Añadir coche')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => v!.isEmpty ? 'Introduce un nombre' : null,
              ),
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(labelText: 'Modelo'),
                validator: (v) => v!.isEmpty ? 'Introduce un modelo' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveCar,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
