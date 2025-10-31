import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/api_service.dart';
import 'add_car_page.dart';
import 'car_detail_page.dart';

class HomePage extends StatefulWidget {
    const HomePage({super.key});
    @override State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    late Future<List<dynamic>> _carsFuture;

    @override
    void initState() {
        super.initState();
        _carsFuture = ApiService.getCars();
    }    

    Future<void> _refresh() async {
        setState(() {_carsFuture = ApiService.getCars(); });
    }

    @override Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Mis coches'),
                actions: [
                    IconButton(icon: const Icon(Icons.logout), onPressed: () async { await FirebaseAuth.instance.signOut(); })
                ],
            ),
            body: FutureBuilder<List<dynamic>>(
                future: _carsFuture,
                builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
                    final cars = snap.data ?? [];
                    if (cars.isEmpty) return Center(child: Text('No tienes coches.'));
                    return RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView.builder(
                            itemCount: cars.length,
                            itemBuilder: (context, i) {
                                final car = cars[i];
                                return ListTile(
                                    title: Text(car['name'] ?? ''),
                                    subtitle: Text('Km: ${car['kilometers'] ?? 0}'),
                                    trailing: const Icon(Icons.arrow_forward_ios),
                                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CarDetailPage(carId: car['id'].toString()))).then((_) => _refresh()),
                                );
                            },
                        ),
                    );
                },
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddCarPage())).then((_) => _refresh()),
                child: const Icon(Icons.add),
            ),
        );
    }
}