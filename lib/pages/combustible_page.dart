import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';

class FuelPage extends StatelessWidget {
  const FuelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Combustible"),
      body: const Center(
        child: Text(
          "Aquí podrás registrar y consultar el combustible gastado.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
