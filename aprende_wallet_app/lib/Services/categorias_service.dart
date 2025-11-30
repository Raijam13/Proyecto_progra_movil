import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoriasService {
  // URL base del backend (ajusta según tu configuración)
  static const String baseUrl = 'http://127.0.0.1:4567';

  // Header común para user_id (opcional, si decides usarlo)
  static Map<String, String> _getHeaders({int? userId}) {
    final headers = {'Content-Type': 'application/json'};
    if (userId != null) {
      headers['X-User-Id'] = userId.toString();
    }
    return headers;
  }

  /// GET /categorias - Listar todas las categorías
  static Future<List<Map<String, dynamic>>> listarCategorias() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categorias'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
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
