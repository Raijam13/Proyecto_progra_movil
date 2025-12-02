import 'dart:convert';
import 'package:http/http.dart' as http;

class CuentasService {
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

  /// GET /cuentas?user_id=:id - Listar cuentas de un usuario
  /// Acepta user_id por query param o header X-User-Id
  static Future<List<Map<String, dynamic>>> listarCuentas(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cuentas?user_id=$userId'),
        headers: _getHeaders(userId: userId),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final List<dynamic> data = body['data'] ?? [];
        return data.cast<Map<String, dynamic>>();
      } else if (response.statusCode == 400) {
        throw Exception('Parámetro user_id es obligatorio');
      } else {
        throw Exception('Error al listar cuentas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en listarCuentas: $e');
      rethrow;
    }
  }

  /// GET /cuentas/:id - Obtener detalle de una cuenta
  static Future<Map<String, dynamic>> obtenerCuenta(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cuentas/$id'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('Cuenta no encontrada');
      } else {
        throw Exception('Error al obtener cuenta: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en obtenerCuenta: $e');
      rethrow;
    }
  }

  /// POST /cuentas - Crear una nueva cuenta
  static Future<Map<String, dynamic>> crearCuenta({
    required String nombre,
    required double saldo,
    required int idUsuario,
    required String codeMoneda, // Ej: "PEN", "USD"
    required String tipoCuenta, // Ej: "Banco", "Efectivo"
  }) async {
    try {
      final body = {
        'nombre': nombre,
        'saldo': saldo,
        'idUsuario': idUsuario,
        'codeMoneda': codeMoneda,
        'tipoCuenta': tipoCuenta,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/cuentas'),
        headers: _getHeaders(),
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        final body = json.decode(response.body);
        return body['data'] ?? {};
      } else if (response.statusCode == 400) {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Error al crear cuenta');
      } else {
        throw Exception('Error al crear cuenta: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en crearCuenta: $e');
      rethrow;
    }
  }

  /// PUT /cuentas/:id - Actualizar una cuenta
  static Future<Map<String, dynamic>> actualizarCuenta({
    required int id,
    String? nombre,
    double? saldo,
    String? tipoCuenta,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (nombre != null) body['nombre'] = nombre;
      if (saldo != null) body['saldo'] = saldo;
      if (tipoCuenta != null) body['tipoCuenta'] = tipoCuenta;

      final response = await http.put(
        Uri.parse('$baseUrl/cuentas/$id'),
        headers: _getHeaders(),
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('Cuenta no encontrada');
      } else if (response.statusCode == 400) {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Error al actualizar cuenta');
      } else {
        throw Exception('Error al actualizar cuenta: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en actualizarCuenta: $e');
      rethrow;
    }
  }

  /// DELETE /cuentas/:id - Eliminar una cuenta
  static Future<Map<String, dynamic>> eliminarCuenta(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/cuentas/$id'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('Cuenta no encontrada');
      } else if (response.statusCode == 400) {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'No se puede eliminar la cuenta');
      } else {
        throw Exception('Error al eliminar cuenta: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en eliminarCuenta: $e');
      rethrow;
    }
  }
}
