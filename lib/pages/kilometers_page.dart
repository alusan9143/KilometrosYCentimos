import 'package:flutter/material.dart';
import 'package:kilometrosycentimos/services/car_service.dart';

class KilometersPage extends StatefulWidget {
  const KilometersPage({super.key});

  @override
  State<KilometersPage> createState() => _KilometersPageState();
}

class _KilometersPageState extends State<KilometersPage> {
  final CarService carService = CarService();
  String? selectedCarId;
  List<Map<String, dynamic>> cars = [];
  final TextEditingController kmController = TextEditingController();

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
                kmController.text =
                    cars.firstWhere((c) => c['id'].toString() == value)['kilometers'].toString();
              });
            },
          ),
          const SizedBox(height: 20),
          if (selectedCarId != null) ...[
            TextField(
              controller: kmController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Kilómetros',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final km = int.tryParse(kmController.text);
                if (km != null) {
                  await carService.updateKilometers(selectedCarId!, km);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Kilómetros actualizados')),
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
