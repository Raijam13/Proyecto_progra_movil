import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PlanificacionController extends GetxController {
  // Método para ir a la pantalla de Pagos Planificados
  void irAPagosPlanificados(BuildContext context) {
    Navigator.pushNamed(context, '/pagosplanificados');
  }

  // Método para ir a la pantalla de Presupuestos
  void irAPresupuestos(BuildContext context) {
    Navigator.pushNamed(context, '/presupuestos');
  }
}
