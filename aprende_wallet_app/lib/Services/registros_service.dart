import 'dart:convert';
import 'package:http/http.dart' as http;

class RegistrosService {
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

  /// GET /registros?user_id=:id&limit=20&offset=0 - Listar registros de un usuario
  static Future<List<Map<String, dynamic>>> listarRegistros({
    required int userId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/registros').replace(queryParameters: {
        'user_id': userId.toString(),
        'limit': limit.toString(),
        'offset': offset.toString(),
      });

      final response = await http.get(
        uri,
        headers: _getHeaders(userId: userId),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else if (response.statusCode == 400) {
        throw Exception('Parámetro user_id es obligatorio');
      } else {
        throw Exception('Error al listar registros: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en listarRegistros: $e');
      rethrow;
    }
  }

  /// GET /registros/:id - Obtener detalle de un registro
  static Future<Map<String, dynamic>> obtenerRegistro(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/registros/$id'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('Registro no encontrado');
      } else {
        throw Exception('Error al obtener registro: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en obtenerRegistro: $e');
      rethrow;
    }
  }

  /// POST /registros - Crear un nuevo registro (actualiza saldo automáticamente)
  static Future<Map<String, dynamic>> crearRegistro({
    required int idUsuario,
    required int idCuenta,
    required int idCategoria,
    required int idTipoTransaccion, // 1 = gasto, 2 = ingreso
    required double monto,
    String? fechaHora, // Formato: "YYYY-MM-DD HH:MM:SS", opcional (usa ahora si no se envía)
  }) async {
    try {
      final body = <String, dynamic>{
        'idUsuario': idUsuario,
        'idCuenta': idCuenta,
        'idCategoria': idCategoria,
        'idTipoTransaccion': idTipoTransaccion,
        'monto': monto,
      };

      if (fechaHora != null) {
        body['fechaHora'] = fechaHora;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/registros'),
        headers: _getHeaders(),
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Error al crear registro');
      } else if (response.statusCode == 404) {
        throw Exception('Cuenta no encontrada');
      } else {
        throw Exception('Error al crear registro: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en crearRegistro: $e');
      rethrow;
    }
  }

  /// DELETE /registros/:id - Eliminar un registro (revierte saldo automáticamente)
  static Future<Map<String, dynamic>> eliminarRegistro(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/registros/$id'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('Registro no encontrado');
      } else {
        throw Exception('Error al eliminar registro: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en eliminarRegistro: $e');
      rethrow;
    }
  }
}
