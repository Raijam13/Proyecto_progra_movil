import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aprende_wallet_app/models/presupuesto_model.dart';
import 'package:aprende_wallet_app/models/generic_response.dart';
import 'package:aprende_wallet_app/config/api_config.dart';

class PresupuestosService {
  static const String baseUrl = ApiConfig.baseUrl;

  List<Presupuesto> _presupuestoListFromJson(dynamic json) {
    return (json as List)
        .map((item) => Presupuesto.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> _catalogosFromJson(dynamic json) {
    if (json is Map<String, dynamic>) return json;
    if (json is Map) return Map<String, dynamic>.from(json);
    return {};
  }

  /// GET /presupuestos?user_id=X
  Future<GenericResponse<List<Presupuesto>>> getPresupuestos(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/presupuestos?user_id=$userId'),
      );

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body);
        return GenericResponse<List<Presupuesto>>.fromJson(
          jsonMap,
          _presupuestoListFromJson,
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

  /// GET /presupuestos/:id
  Future<GenericResponse<Presupuesto>> getPresupuestoById(
    int id,
    int userId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/presupuestos/$id?user_id=$userId'),
      );

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body);
        return GenericResponse<Presupuesto>.fromJson(
          jsonMap,
          (data) => Presupuesto.fromJson(data as Map<String, dynamic>),
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

  /// GET /presupuestos/catalogos
  Future<GenericResponse<Map<String, dynamic>>> getCatalogos(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pagos-planificados/catalogos?user_id=$userId'),
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

  /// POST /presupuestos
  Future<GenericResponse<void>> createPresupuesto(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/presupuestos'),
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
        message: "Error al crear presupuesto: $e",
      );
    }
  }

  /// PUT /presupuestos/:id
  Future<GenericResponse<void>> updatePresupuesto(
    int id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/presupuestos/$id'),
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
        message: "Error al actualizar presupuesto: $e",
      );
    }
  }

  /// DELETE /presupuestos/:id
  Future<GenericResponse<void>> deletePresupuesto(int id, int userId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/presupuestos/$id?user_id=$userId'),
      );

      final jsonMap = json.decode(response.body);
      return GenericResponse(
        success: jsonMap['success'] ?? false,
        message: jsonMap['message'],
      );
    } catch (e) {
      return GenericResponse(
        success: false,
        message: "Error al eliminar presupuesto: $e",
      );
    }
  }
}
