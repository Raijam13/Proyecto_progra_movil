import 'dart:convert';
import 'package:aprende_wallet_app/models/generic_response.dart';
import 'package:aprende_wallet_app/models/pago_planificado_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class PagosPlanificadosService {
  /// Convierte una lista dinámica de JSON en una lista de objetos [PagoPlanificado].
  List<PagoPlanificado> _pagoListFromJson(dynamic json) {
    return (json as List)
        .map((pagoJson) =>
            PagoPlanificado.fromJson(pagoJson as Map<String, dynamic>))
        .toList();
  }

  /// Simula la obtención de la lista de pagos planificados.
  Future<GenericResponse<List<PagoPlanificado>>> getPagosPlanificados() async {
    try {
      final jsonString = await rootBundle
          .loadString('assets/data/pagos_planificados_response.json');

      final jsonMap = json.decode(jsonString);

      final response = GenericResponse<List<PagoPlanificado>>.fromJson(
        jsonMap,
        _pagoListFromJson,
      );

      return response;
    } catch (e, stackTrace) {
      print('Error al cargar pagos planificados: $e');
      print('Stack trace: $stackTrace');
      return GenericResponse(
        success: false,
        message: "Error inesperado al cargar los pagos planificados.",
        error: e.toString(),
      );
    }
  }
}