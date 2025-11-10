import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AuthService {
  Future<void> signUp(String email, String password) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Error al registrarse');
    }
  }

  Future<void> signIn(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Error al iniciar sesión');
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  User? get currentUser => supabase.auth.currentUser;
}
