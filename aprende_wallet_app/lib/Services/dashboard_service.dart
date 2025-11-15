import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardService {
  static const String baseUrl = 'http://10.0.2.2:4567';
  
  static Map<String, String> _getHeaders({int? userId}) {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (userId != null) {
      headers['X-User-Id'] = userId.toString();
    }
    return headers;
  }

  /// GET /dashboard/summary?user_id=:id&period=month&year=2025&month=11
  /// Obtiene resumen de gastos con top 3 categorías
  static Future<Map<String, dynamic>> obtenerResumen({
    required int userId,
    String period = 'month',
    int? year,
    int? month,
  }) async {
    try {
      final queryParams = {
        'user_id': userId.toString(),
        'period': period,
      };

      if (year != null) queryParams['year'] = year.toString();
      if (month != null) queryParams['month'] = month.toString();

      final uri = Uri.parse('$baseUrl/dashboard/summary').replace(
        queryParameters: queryParams,
      );

      final response = await http.get(
        uri,
        headers: _getHeaders(userId: userId),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        throw Exception('Parámetro user_id es obligatorio');
      } else {
        throw Exception('Error al obtener resumen: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en obtenerResumen: $e');
      rethrow;
    }
  }

  /// GET /dashboard/total-balance?user_id=:id
  /// Obtiene el balance total de todas las cuentas del usuario
  static Future<Map<String, dynamic>> obtenerBalanceTotal(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/dashboard/total-balance?user_id=$userId'),
        headers: _getHeaders(userId: userId),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        throw Exception('Parámetro user_id es obligatorio');
      } else {
        throw Exception('Error al obtener balance total: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en obtenerBalanceTotal: $e');
      rethrow;
    }
  }
}
