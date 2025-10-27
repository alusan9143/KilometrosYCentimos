import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'kilometers_page.dart';
import 'fuel_page.dart';
import 'mechanic_page.dart';

class CarDetailPage extends StatefulWidget {
  final String carId;
  const CarDetailPage({super.key, required this.carId});
  @override State<CarDetailPage> createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  Map<String, dynamic>? _car;
  bool _loading = false;

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      _car = await ApiService.getCar(widget.carId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override void initState() { super.initState(); _load(); }

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_car?['name'] ?? 'Detalle')),
      body: _loading ? const Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Modelo: ${_car?['model'] ?? ''}'),
          Text('Kilómetros: ${_car?['kilometers'] ?? 0}'),
          Text('Combustible: ${_car?['fuel'] ?? 0.0} L'),
          Text('Visitas: ${_car?['visits'] ?? 0}'),
          const SizedBox(height: 20),
          ElevatedButton.icon(icon: const Icon(Icons.speed), label: const Text('Editar Kms'), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => KilometersPage(carId: widget.carId))).then((_) => _load())),
          ElevatedButton.icon(icon: const Icon(Icons.local_gas_station), label: const Text('Combustible'), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FuelPage(carId: widget.carId))).then((_) => _load())),
          ElevatedButton.icon(icon: const Icon(Icons.build), label: const Text('Visitas'), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MechanicPage(carId: widget.carId))).then((_) => _load())),
        ]),
      ),
    );
  }
}
