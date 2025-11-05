import 'package:firebase_auth/firebase_auth.dart';
import 'package:kilometrosycentimos/services/supabase_service.dart';

class CarService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Método para asegurar que el usuario existe en Supabase
  Future<void> _ensureUserExists(User user) async {
    try {
      await supabase.from('users').upsert({
        'id': user.uid,
        'email': user.email,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error en ensureUserExists: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getCars() async {
    final user = auth.currentUser;
    if (user == null) return [];

    try {
      final response = await supabase
          .from('cars')
          .select()
          .eq('user_id', user.uid);

      if (response.isEmpty) return [];
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error obteniendo coches: $e');
      return [];
    }
  }

  Future<void> createCar(String name, 
                        String model, {
                          int kilometers = 0,
                          double fuel = 0.0,
                          int visits = 0,
                        }) async {
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('Usuario no autenticado');
    }

    try {
      // Asegurar que el usuario existe en Supabase
      await _ensureUserExists(user);

      final response = await supabase.from('cars').insert({
        'name': name,
        'model': model,
        'kilometers': kilometers,
        'fuel': fuel,
        'visits': visits,
        'user_id': user.uid,
        'created_at': DateTime.now().toIso8601String(),
      }).select();

      print('Coche creado exitosamente: $response');
      
    } catch (e) {
      print('Error creando coche: $e');
      throw Exception('No se pudo crear el coche: $e');
    }
  }

  // 🔁 Actualizar kilómetros
  Future<void> updateKilometers(String id, int kilometers) async {
    await supabase.from('cars').update({'kilometers': kilometers}).eq('id', id);
  }

  // ⛽ Actualizar combustible
  Future<void> updateFuel(String id, int fuel) async {
    await supabase.from('cars').update({'fuel': fuel}).eq('id', id);
  }

  // 🧰 Actualizar visitas al mecánico
  Future<void> updateVisits(String id, int visits) async {
    await supabase.from('cars').update({'visits': visits}).eq('id', id);
  }
}
