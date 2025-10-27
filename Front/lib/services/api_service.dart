import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // Cambiar la URL por la del Backend
  static const String baseUrl = '';

  static Future<Map<String, String>> _authHeaders() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated');
    final idToken = await user.getIdToken();
    return {
      'Authorization' : 'Bearer $idToken',
      'Content-Type' : 'application/json',
    };
  }

  static Future<List<dynamic>> getCars() async {
    final headers = await _authHeaders();
    final resp = await http.get(Uri.parse('$baseUrl/cars'), headers: headers);
    if (resp.statusCode == 200) return List.from(jsonDecode(resp.body));
    throw Exception('Error fetching cars: ${resp.body}');
  }

  static Future<Map<String, dynamic>> createCar(String name, String model) async {
    final headers = await _authHeaders();
    final resp = await http.post(Uri.parse('$baseUrl/cars'),
        headers: headers, body: jsonEncode({'name': name, 'model': model}));
    if (resp.statusCode == 201) return jsonDecode(resp.body);
    throw Exception('Error creating car: ${resp.body}');
  }

  static Future<Map<String, dynamic>> getCar(String id) async {
    final headers = await _authHeaders();
    final resp = await http.get(Uri.parse('$baseUrl/cars/$id'), headers: headers);
    if (resp.statusCode == 200) return jsonDecode(resp.body);
    throw Exception('Error fetching car: ${resp.body}');
  }

  static Future<void> updateKilometers(String id, int kms) async {
    final headers = await _authHeaders();
    final resp = await http.post(Uri.parse('$baseUrl/cars/$id/kilometers'),
        headers: headers, body: jsonEncode({'Kilometers': kms}));
    if (resp.statusCode != 200) throw Exception('Error updating kms');
  }

  static Future<void> updateFuel(String id, double fuel) async {
    final headers = await _authHeaders();
    final resp = await http.post(Uri.parse('$baseUrl/cars/$id/fuel'),
        headers: headers, body: jsonEncode({'Fuel': fuel}));
    if (resp.statusCode != 200) throw Exception('Error updating fuel');
  }
  
  static Future<void> updateVisits(String id, int visits) async {
    final headers = await _authHeaders();
    final resp = await http.post(Uri.parse('$baseUrl/cars/$id/visits'),
        headers: headers, body: jsonEncode({'Visits': visits}));
    if (resp.statusCode != 200) throw Exception('Error updating visits');
  }

}