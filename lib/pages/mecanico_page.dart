import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';

class MechanicPage extends StatelessWidget {
  const MechanicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Mecánico"),
      body: const Center(
        child: Text(
          "Aquí podrás ver las revisiones y reparaciones del coche.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
