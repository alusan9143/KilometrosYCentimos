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
  final _kilometersController = TextEditingController();
  final _fuelController = TextEditingController();
  final _visitsController = TextEditingController();
  final CarService carService = CarService();

  void _saveCar() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final model = _modelController.text.trim();
      final kilometers = int.tryParse(_kilometersController.text) ?? 0;
      final fuel = double.tryParse(_fuelController.text) ?? 0.0;
      final visits = int.tryParse(_visitsController.text) ?? 0;

      await carService.createCar(
        name,
        model,
        kilometers: kilometers,
        fuel: fuel,
        visits: visits,
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
          child: ListView(
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
              TextFormField(
                controller: _kilometersController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Kilómetros'),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Introduce los kilómetros';
                  if (int.tryParse(v) == null) return 'Debe ser un número entero';
                  return null;
                },
              ),
              TextFormField(
                controller: _fuelController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Combustible (L)'),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Introduce el combustible';
                  if (double.tryParse(v) == null) return 'Debe ser un número válido';
                  return null;
                },
              ),
              TextFormField(
                controller: _visitsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Visitas al taller'),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Introduce el número de visitas';
                  if (int.tryParse(v) == null) return 'Debe ser un número entero';
                  return null;
                },
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
