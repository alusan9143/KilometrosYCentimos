import 'package:flutter/material.dart';
import '../services/car_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarService carService = CarService();
  List <Map<String, dynamic>> cars = [];

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
      appBar: AppBar(title: const Text('Mis coches')),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return ListTile(
            title: Text(car['name']),
            subtitle: Text('Modelo: ${car['model']}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await carService.createCar('Seat Ibiza', '2020');
          loadCars();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}