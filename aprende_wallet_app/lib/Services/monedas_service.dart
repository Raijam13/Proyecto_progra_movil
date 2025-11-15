import 'dart:convert';
import 'package:http/http.dart' as http;

class MonedasService {
  static const String baseUrl = 'http://10.0.2.2:4567';
  
  static Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
    };
  }

  /// GET /monedas - Listar todas las monedas
  static Future<List<Map<String, dynamic>>> listarMonedas() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/monedas'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Error al listar monedas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en listarMonedas: $e');
      rethrow;
    }
  }

  /// GET /monedas/:code - Obtener una moneda por código (PEN, USD, etc.)
  static Future<Map<String, dynamic>> obtenerMoneda(String code) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/monedas/$code'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('Moneda no encontrada');
      } else {
        throw Exception('Error al obtener moneda: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en obtenerMoneda: $e');
      rethrow;
    }
  }
}
