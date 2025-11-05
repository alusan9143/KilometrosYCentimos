import 'package:flutter/material.dart';
import 'package:kilometrosycentimos/services/car_service.dart';

class MechanicPage extends StatefulWidget {
  const MechanicPage({super.key});

  @override
  State<MechanicPage> createState() => _MechanicPageState();
}

class _MechanicPageState extends State<MechanicPage> {
  final CarService carService = CarService();
  String? selectedCarId;
  List<Map<String, dynamic>> cars = [];
  final TextEditingController visitsController = TextEditingController();

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
                visitsController.text =
                    cars.firstWhere((c) => c['id'].toString() == value)['visits'].toString();
              });
            },
          ),
          const SizedBox(height: 20),
          if (selectedCarId != null) ...[
            TextField(
              controller: visitsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Visitas al mecánico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final visits = int.tryParse(visitsController.text);
                if (visits != null) {
                  await carService.updateVisits(selectedCarId!, visits);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Visitas actualizadas')),
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
