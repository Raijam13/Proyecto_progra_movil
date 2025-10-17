import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgregarPresupuestoController extends GetxController {
  // Estados observables para los campos del formulario
  final monto = 0.0.obs;
  final nombre = ''.obs;
  final periodo = 'Mensual'.obs;
  final categorias = <String>[].obs;
  final cuentas = <String>[].obs;

  final isLoading = false.obs;

  // TODO: Implementar métodos para abrir modales de selección
  void editarMonto(BuildContext context) {
    // Lógica para mostrar modal de edición de monto
    Get.snackbar('Info', 'Funcionalidad de editar monto pendiente.');
  }

  void editarNombre(BuildContext context) {
    // Lógica para mostrar modal de edición de nombre
    Get.snackbar('Info', 'Funcionalidad de editar nombre pendiente.');
  }

  void seleccionarPeriodo(BuildContext context) {
    // Lógica para mostrar modal de selección de periodo
    Get.snackbar('Info', 'Funcionalidad de seleccionar periodo pendiente.');
  }

  void seleccionarCategorias(BuildContext context) {
    // Lógica para mostrar modal de selección de categorías
    Get.snackbar('Info', 'Funcionalidad de seleccionar categorías pendiente.');
  }

  void seleccionarCuentas(BuildContext context) {
    // Lógica para mostrar modal de selección de cuentas
    Get.snackbar('Info', 'Funcionalidad de seleccionar cuentas pendiente.');
  }

  void guardarPresupuesto() async {
    if (nombre.value.isEmpty || monto.value <= 0) {
      Get.snackbar('Error', 'El nombre y el monto son requeridos.');
      return;
    }

    isLoading.value = true;
    // Aquí iría la llamada al servicio para guardar el presupuesto
    await Future.delayed(const Duration(seconds: 1)); // Simular llamada a API
    isLoading.value = false;

    Get.back(); // Volver a la página anterior
    Get.snackbar('Éxito', 'Presupuesto "${nombre.value}" guardado.');
  }
}