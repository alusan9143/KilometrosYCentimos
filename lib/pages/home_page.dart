import 'package:flutter/material.dart';
import '../services/car_service.dart';
import 'add_car_page.dart';
import 'kilometers_page.dart';
import 'fuel_page.dart';
import 'mechanic_page.dart';
import 'car_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  void _showCarOptions(Map<String, dynamic> car) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Ver detalles'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CarDetailPage(car: car)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.speed),
            title: const Text('Editar kilómetros'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => KilometersPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_gas_station),
            title: const Text('Editar combustible'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FuelPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.build),
            title: const Text('Editar visitas al mecánico'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MechanicPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis coches')),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return ListTile(
            title: Text(car['name']),
            subtitle: Text('Modelo: ${car['model']}'),
            onTap: () => _showCarOptions(car),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final created = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCarPage()),
          );
          if (created == true) {
            loadCars();
          }
        },
      ),
    );
  }
}
