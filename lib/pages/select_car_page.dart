import 'package:flutter/material.dart';
import '../services/car_service.dart';

class SelectCarPage extends StatefulWidget {
  const SelectCarPage({super.key});

  @override
  State<SelectCarPage> createState() => _SelectCarPageState();
}

class _SelectCarPageState extends State<SelectCarPage> {
  final CarService carService = CarService();
  List<Map<String, dynamic>> cars = [];

  @override
  void initState() {
    super.initState();
    loadCars();
  }

  Future<void> loadCars() async {
    final data = await carService.getCars();
    setState(() => cars = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seleccionar coche')),
      body: cars.isEmpty
          ? const Center(child: Text('No tienes coches registrados.'))
          : ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                return ListTile(
                  title: Text(car['name'] ?? 'Sin nombre'),
                  subtitle: Text('Modelo: ${car['model'] ?? ''}'),
                  onTap: () {
                    Navigator.pop(context, car); // ⬅️ Devuelve el coche seleccionado
                  },
                );
              },
            ),
    );
  }
}