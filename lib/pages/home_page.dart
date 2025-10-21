import 'package:flutter/material.dart';
import 'car_detail_page.dart';
import '../widgets/app_top_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> coches = ["Toyota Yaris", "Ford Focus", "Tesla Model 3"];

    return Scaffold(
      appBar: customAppBar(context, "Mis Coches", showBackButton: false),
      body: ListView.builder(
        itemCount: coches.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(coches[index]),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CarDetailPage(nombre: coches[index])),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí podrías abrir un formulario para crear un nuevo coche
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
