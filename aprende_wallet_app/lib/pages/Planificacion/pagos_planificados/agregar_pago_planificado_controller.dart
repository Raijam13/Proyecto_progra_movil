import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AgregarPagoPlanificadoController extends GetxController {
  // Estados observables para los campos del formulario
  final monto = 0.0.obs;
  final nombre = ''.obs;
  final tipo = 'gasto'.obs; // 'gasto' o 'ingreso'
  final periodo = 'Mensual'.obs;
  final categoria = ''.obs;
  final cuenta = ''.obs;

  final isLoading = false.obs;

  void setTipo(String nuevoTipo) {
    tipo.value = nuevoTipo;
  }

  void setMonto(double nuevoMonto) {
    monto.value = nuevoMonto;
  }

  void editarNombre(BuildContext context) {
    // TODO: Implementar modal para editar nombre
    Get.snackbar('Info', 'Funcionalidad de editar nombre pendiente.');
  }

  void seleccionarTipo(BuildContext context) {}

  void editarMonto(BuildContext context) {}

  void seleccionarPeriodo(BuildContext context) =>
      Get.snackbar('Info', 'Funcionalidad pendiente.');

  void seleccionarCategoria(BuildContext context) =>
      Get.snackbar('Info', 'Funcionalidad pendiente.');

  void seleccionarCuenta(BuildContext context) =>
      Get.snackbar('Info', 'Funcionalidad pendiente.');

  void guardarPagoPlanificado() async {
    if (nombre.value.isEmpty || monto.value <= 0) {
      Get.snackbar('Error', 'El nombre y el monto son requeridos.');
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // Simular API
    isLoading.value = false;

    Get.back();
    Get.snackbar('Éxito', 'Pago "${nombre.value}" guardado.');
  }
}