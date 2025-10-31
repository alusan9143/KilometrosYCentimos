import 'package:flutter/material.dart';
import 'package:kilometrosycentimos/pages/home_page.dart';
import 'package:kilometrosycentimos/pages/kilometers_page.dart';
import 'package:kilometrosycentimos/pages/fuel_page.dart';
import 'package:kilometrosycentimos/pages/mechanic_page.dart';
import 'package:kilometrosycentimos/services/auth_service.dart';
import 'package:kilometrosycentimos/pages/login_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const KilometersPage(carId: '1'), // Ejemplo
    const FuelPage(carId: '1'),
    const MechanicPage(carId: '1'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kilómetros y Céntimos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              await firebaseAuth.signOut();
              if (context.mounted) {
                // Redirige a login tras cerrar sesión
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.speed), label: 'KM'),
          BottomNavigationBarItem(icon: Icon(Icons.local_gas_station), label: 'Combustible'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Mecánico'),
        ],
      ),
    );
  }
}
