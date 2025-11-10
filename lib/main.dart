import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/main_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    final session = Supabase.instance.client.auth.currentSession;
    return MaterialApp(
      home: session == null ? const LoginPage() : const MainWrapper(),
    );
  }
}
