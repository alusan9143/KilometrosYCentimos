import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(BuildContext context, String title, {bool showBackButton = true}) {
  return AppBar(
    backgroundColor: Colors.blue, // fondo azul
    title: Text(title, style: const TextStyle(color: Colors.white)),
    centerTitle: true,
    leading: showBackButton
        ? IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          )
        : null,
    actions: [
      IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Menú desplegable aún no implementado")),
          );
        },
      ),
    ],
  );
}
