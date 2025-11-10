import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kilometrosycentimos/services/storage_service.dart';
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
  final _yearController = TextEditingController(); // ✅ Nuevo controller para año
  final _kilometersController = TextEditingController();
  final _fuelController = TextEditingController();
  final _visitsController = TextEditingController();

  final CarService carService = CarService();
  final ImagePicker _picker = ImagePicker();

  File? _imageFile;
  bool _loading = false; // ✅ Agregar estado de carga

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 75);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveCar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
    });

    try {
      await carService.createCar(
        name: _nameController.text.trim(),
        model: _modelController.text.trim(),
        year: int.tryParse(_yearController.text), // ✅ Agregar año
        kilometers: int.tryParse(_kilometersController.text) ?? 0,
        fuel: double.tryParse(_fuelController.text) ?? 0.0,
        visits: int.tryParse(_visitsController.text) ?? 0,
        imageFile: _imageFile,
      );

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear coche: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
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
              // 🖼️ --- SECCIÓN DE IMAGEN ---
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? const Icon(Icons.directions_car, size: 60)
                          : null,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: _loading ? null : () => _pickImage(ImageSource.gallery),
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Galería'),
                        ),
                        TextButton.icon(
                          onPressed: _loading ? null : () => _pickImage(ImageSource.camera),
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Cámara'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // 📋 --- CAMPOS DE FORMULARIO ---
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => v!.isEmpty ? 'Introduce un nombre' : null,
                enabled: !_loading,
              ),
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(labelText: 'Modelo'),
                validator: (v) => v!.isEmpty ? 'Introduce un modelo' : null,
                enabled: !_loading,
              ),
              // ✅ NUEVO CAMPO PARA EL AÑO
              TextFormField(
                controller: _yearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Año',
                  hintText: 'Ej: 2020',
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Introduce el año';
                  final year = int.tryParse(v);
                  if (year == null) return 'Debe ser un número válido';
                  if (year < 1900 || year > DateTime.now().year + 1) {
                    return 'Año debe estar entre 1900 y ${DateTime.now().year + 1}';
                  }
                  return null;
                },
                enabled: !_loading,
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
                enabled: !_loading,
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
                enabled: !_loading,
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
                enabled: !_loading,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loading ? null : _saveCar,
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}