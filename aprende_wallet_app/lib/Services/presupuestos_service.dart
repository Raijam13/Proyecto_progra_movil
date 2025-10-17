import 'dart:convert';
import 'package:aprende_wallet_app/models/presupuesto_model.dart';
import 'package:aprende_wallet_app/models/generic_response.dart';
import 'package:flutter/services.dart' show rootBundle;

class PresupuestosService {
  /// Convierte una lista dinámica de JSON en una lista de objetos [Presupuesto].
  List<Presupuesto> _presupuestoListFromJson(dynamic json) {
    return (json as List)
        .map((presupuestoJson) =>
            Presupuesto.fromJson(presupuestoJson as Map<String, dynamic>))
        .toList();
  }

  /// Simula la obtención de la lista de presupuestos desde una fuente de datos.
  ///
  /// En un futuro, aquí iría la lógica para conectar a Firebase, una API REST, etc.
  Future<GenericResponse<List<Presupuesto>>> getPresupuestos() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/presupuestos_response.json');

      final jsonMap = json.decode(jsonString);

      // Usamos nuestro nuevo modelo genérico para parsear la respuesta.
      final response = GenericResponse<List<Presupuesto>>.fromJson(
        jsonMap,
        _presupuestoListFromJson,
      );

      return response;
    } catch (e, stackTrace) {
      // Manejo de errores (p. ej., si el archivo no se encuentra o el JSON es inválido)
      print('Error al cargar presupuestos: $e');
      print('Stack trace: $stackTrace');
      return GenericResponse(
        success: false,
        message: "Error inesperado al cargar los presupuestos.",
        error: e.toString(),
      );
    }
  }
}