import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';

class KilometersPage extends StatelessWidget {
  const KilometersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Kilómetros"),
      body: const Center(
        child: Text(
          "Aquí podrás ver y registrar los kilómetros de tu coche.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
