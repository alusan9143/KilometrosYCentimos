import 'package:flutter/material.dart';
import 'package:kilometrosycentimos/services/car_service.dart';

class FuelPage extends StatefulWidget {
  const FuelPage({super.key});

  @override
  State<FuelPage> createState() => _FuelPageState();
}

class _FuelPageState extends State<FuelPage> {
  final CarService carService = CarService();
  String? selectedCarId;
  List<Map<String, dynamic>> cars = [];
  final TextEditingController fuelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadCars();
  }

  Future<void> loadCars() async {
    final fetched = await carService.getCars();
    setState(() {
      cars = fetched;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Selecciona un coche:', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          DropdownButton<String>(
            value: selectedCarId,
            hint: const Text('Elige un coche'),
            isExpanded: true,
            items: cars.map((car) {
              return DropdownMenuItem(
                value: car['id'].toString(),
                child: Text('${car['name']} (${car['model']})'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCarId = value;
                fuelController.text =
                    cars.firstWhere((c) => c['id'].toString() == value)['fuel'].toString();
              });
            },
          ),
          const SizedBox(height: 20),
          if (selectedCarId != null) ...[
            TextField(
              controller: fuelController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Combustible (L)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final fuel = int.tryParse(fuelController.text);
                if (fuel != null) {
                  await carService.updateFuel(selectedCarId!, fuel);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Combustible actualizado')),
                  );
                }
              },
              child: const Text('Guardar cambios'),
            ),
          ],
        ],
      ),
    );
  }
}
