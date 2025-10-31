import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kilometrosycentimos/services/auth_service.dart';
import 'firebase_options.dart';
import 'pages/login_page.dart';
import 'pages/main_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializamos Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Inicializamos Supabase
  await Supabase.initialize(
    url: 'https://avfpwvspmexngafpiwje.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF2ZnB3dnNwbWV4bmdhZnBpd2plIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE1MDEyODUsImV4cCI6MjA3NzA3NzI4NX0.eot97vaMD34ODCO7aHHC1qshQbOl_8-x5k4O7NW3cSw',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kilómetros y Céntimos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(), // Directamente al login
    );
  }
}