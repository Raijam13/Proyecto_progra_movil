import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:aprende_wallet_app/config/api_config.dart';

class TiposService {
  static const String baseUrl = ApiConfig.baseUrl;

  static Map<String, String> _getHeaders() {
    return {'Content-Type': 'application/json'};
  }

  /// GET /tipos-cuenta - Listar todos los tipos de cuenta
  static Future<List<Map<String, dynamic>>> listarTiposCuenta() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tipos-cuenta'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception(
          'Error al listar tipos de cuenta: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error en listarTiposCuenta: $e');
      rethrow;
    }
  }

  /// GET /tipos-transaccion - Listar tipos de transacción (gasto/ingreso)
  static Future<List<Map<String, dynamic>>> listarTiposTransaccion() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tipos-transaccion'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception(
          'Error al listar tipos de transacción: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error en listarTiposTransaccion: $e');
      rethrow;
    }
  }
}
