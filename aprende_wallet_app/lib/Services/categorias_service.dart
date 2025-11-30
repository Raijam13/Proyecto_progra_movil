import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:aprende_wallet_app/config/api_config.dart';

class CategoriasService {
  // URL base del backend (ajusta según tu configuración)
  static const String baseUrl = ApiConfig.baseUrl;

  // Header común para user_id (opcional, si decides usarlo)
  static Map<String, String> _getHeaders({int? userId}) {
    final headers = {'Content-Type': 'application/json'};
    if (userId != null) {
      headers['X-User-Id'] = userId.toString();
    }
    return headers;
  }

  /// GET /categorias - Listar todas las categorías
  static Future<List<Map<String, dynamic>>> listarCategorias(
    int? userId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categorias'),
        headers: _getHeaders(userId: userId),
      );

      if (response.statusCode == 200) {
        final dynamic decoded = json.decode(response.body);
        List<dynamic> data;
        if (decoded is Map<String, dynamic> && decoded.containsKey('data')) {
          data = decoded['data'];
        } else if (decoded is List) {
          data = decoded;
        } else {
          data = [];
        }
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Error al listar categorías: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en listarCategorias: $e');
      rethrow;
    }
  }

  /// GET /categorias/:id - Obtener una categoría por ID
  static Future<Map<String, dynamic>> obtenerCategoria(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categorias/$id'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('Categoría no encontrada');
      } else {
        throw Exception('Error al obtener categoría: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en obtenerCategoria: $e');
      rethrow;
    }
  }
}
