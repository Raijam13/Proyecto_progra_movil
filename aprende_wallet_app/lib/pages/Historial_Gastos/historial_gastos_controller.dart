import 'package:get/get.dart';

class Gasto {
  final int id;
  final String descripcion;
  final double monto;
  final String categoria;
  final String fecha;

  Gasto({
    required this.id,
    required this.descripcion,
    required this.monto,
    required this.categoria,
    required this.fecha,
  });
}

class HistorialGastosController extends GetxController {
  // Lista observable de gastos
  var listaGastos = <Gasto>[].obs;

  // Estado de carga
  var cargando = true.obs;

  // Método para cargar los datos (simulados por ahora)
  Future<void> cargarHistorial() async {
    try {
      cargando.value = true;

      // Simulación de un pequeño retraso (como si fuera una llamada HTTP)
      await Future.delayed(const Duration(seconds: 1));

      // Datos simulados
      listaGastos.value = [
        Gasto(id: 1, descripcion: "Compra supermercado", monto: 120.5, categoria: "Alimentación", fecha: "2025-10-10"),
        Gasto(id: 2, descripcion: "Pasaje de bus", monto: 3.5, categoria: "Transporte", fecha: "2025-10-12"),
        Gasto(id: 3, descripcion: "Pago Netflix", monto: 35.0, categoria: "Entretenimiento", fecha: "2025-10-13"),
      ];
    } catch (e) {
      print("Error al cargar gastos: $e");
    } finally {
      cargando.value = false;
    }
  }
}
