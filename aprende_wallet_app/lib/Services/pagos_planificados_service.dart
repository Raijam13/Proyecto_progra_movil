import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aprende_wallet_app/models/generic_response.dart';
import 'package:aprende_wallet_app/models/pago_planificado_model.dart';

import 'package:aprende_wallet_app/config/api_config.dart';

class PagosPlanificadosService {
  // Use 127.0.0.1 for physical device with 'adb reverse tcp:4567 tcp:4567'
  static const String baseUrl = ApiConfig.baseUrl;

  /// Helper to parse list of payments
  List<PagoPlanificado> _pagoListFromJson(dynamic json) {
    return (json as List)
        .map(
          (pagoJson) =>
              PagoPlanificado.fromJson(pagoJson as Map<String, dynamic>),
        )
        .toList();
  }

  /// Helper to parse catalog items (generic map)
  Map<String, dynamic> _catalogosFromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return json;
    }
    // Handle case where json might be Map<dynamic, dynamic>
    if (json is Map) {
      return Map<String, dynamic>.from(json);
    }
    return {};
  }

  /// GET /pagos-planificados
  Future<GenericResponse<List<PagoPlanificado>>> getPagosPlanificados() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/pagos-planificados'));

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body);
        return GenericResponse<List<PagoPlanificado>>.fromJson(
          jsonMap,
          _pagoListFromJson,
        );
      } else {
        return GenericResponse(
          success: false,
          message: "Error ${response.statusCode}: ${response.body}",
        );
      }
    } catch (e) {
      return GenericResponse(
        success: false,
        message: "Error de conexión: $e",
        error: e.toString(),
      );
    }
  }

  /// GET /pagos-planificados/catalogos
  Future<GenericResponse<Map<String, dynamic>>> getCatalogos() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pagos-planificados/catalogos'),
      );

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body);
        return GenericResponse<Map<String, dynamic>>.fromJson(
          jsonMap,
          _catalogosFromJson,
        );
      } else {
        return GenericResponse(
          success: false,
          message: "Error al obtener catálogos",
        );
      }
    } catch (e) {
      return GenericResponse(
        success: false,
        message: "Error de conexión: $e",
        error: e.toString(),
      );
    }
  }

  /// POST /pagos-planificados
  Future<GenericResponse<void>> createPagoPlanificado(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pagos-planificados'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );

      final jsonMap = json.decode(response.body);
      return GenericResponse(
        success: jsonMap['success'] ?? false,
        message: jsonMap['message'],
        error: jsonMap['error'],
      );
    } catch (e) {
      return GenericResponse(
        success: false,
        message: "Error al crear pago: $e",
      );
    }
  }

  /// DELETE /pagos-planificados/:id
  Future<GenericResponse<void>> deletePagoPlanificado(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/pagos-planificados/$id'),
      );

      final jsonMap = json.decode(response.body);
      return GenericResponse(
        success: jsonMap['success'] ?? false,
        message: jsonMap['message'],
      );
    } catch (e) {
      return GenericResponse(
        success: false,
        message: "Error al eliminar pago: $e",
      );
    }
  }
}
