import 'package:kilometrosycentimos/services/supabase_service.dart';

class RefuelService {

  // Obtener todos los repostajes de un coche
  Future<List<Map<String, dynamic>>> getRefuels(String carId) async {
    final response = await supabase.from('refuels').select().eq('car_id', carId).order('date', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  // Agregar un nuevo repostaje
  Future<void> addRefuel(String carId, double liters, double price, DateTime date) async {
    await supabase.from('refuels').insert({
      'car_id': carId,
      'liters': liters,
      'price': price,
      'date': date.toIso8601String(),
    });
  }
}