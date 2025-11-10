import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  static final SupabaseClient supabase = Supabase.instance.client;

  static Future<String?> uploadCarImage(File imageFile, String carId) async {
    try {
      final String fileName = 'car_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = 'cars/$carId/$fileName';

      // Subir imagen al bucket
      await supabase.storage
          .from('car_images') // Nombre del bucket
          .upload(filePath, imageFile);

      // Obtener URL pública
      final String publicUrl = supabase.storage
          .from('car_images')
          .getPublicUrl(filePath);

      return publicUrl;
    } catch (e) {
      print('Error subiendo imagen: $e');
      return null;
    }
  }
}