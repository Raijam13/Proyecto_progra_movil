import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Crear_cuenta/edicion_modals/editar_nombre_cuenta.dart';
import '../Crear_cuenta/edicion_modals/editar_saldo_cuenta.dart';
import '../Crear_cuenta/edicion_modals/seleccionar_moneda.dart';
import '../Crear_cuenta/edicion_modals/seleccionar_tipo_cuenta.dart';

class CrearCuentaController extends GetxController {
  // Campos de la cuenta
  RxString accountName = 'Mi cuenta'.obs;
  RxDouble currentBalance = 0.00.obs;
  RxString currency = 'PEN'.obs;
  RxString accountType = 'Efectivo'.obs;
  
  // Toggle de acciones
  RxBool excludeFromStats = false.obs;

  // Método para cancelar (volver atrás)
  void cancel(BuildContext context) {
    Navigator.pop(context);
  }

  // Método para navegar a editar nombre de cuenta
  void editAccountName(BuildContext context) {
    EditarNombreCuentaModal.show(
      context: context,
      initialValue: accountName.value,
      onChanged: (value) {
      // Actualización en tiempo real
      accountName.value = value;
    },
    onAccept: (value) {
      // Al aceptar
      accountName.value = value;
    },
  );
  }

  // Método para navegar a editar saldo actual
  void editCurrentBalance(BuildContext context) {
    EditarSaldoCuentaModal.show(
      context: context,
      initialValue: currentBalance.value,
      currency: currency.value,
      onChanged: (value) {
      // Actualización en tiempo real
      currentBalance.value = value;
    },
    onAccept: (value) {
      // Al aceptar
      currentBalance.value = value;
    },
  );
  }

  // Método para navegar a seleccionar moneda
  void selectCurrency(BuildContext context) {
    SeleccionarMonedaModal.show(
      context: context,
      selectedCurrency: currency.value,
      onSelect: (value) {
        currency.value = value;
    },
  );
  }

  // Método para navegar a seleccionar tipo de cuenta
  void selectAccountType(BuildContext context) {
    SeleccionarTipoCuentaModal.show(
      context: context,
      selectedType: accountType.value,
      onSelect: (value) {
        accountType.value = value;
    },
  );
  }

  // Método para toggle de estadísticas
  void toggleExcludeFromStats(bool value) {
    excludeFromStats.value = value;
  }

  // Método para guardar la cuenta
  void saveAccount(BuildContext context) {
    // Validar datos
    if (accountName.value.isEmpty) {
      Get.snackbar(
        'Error',
        'El nombre de la cuenta no puede estar vacío',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Por ahora solo imprime los datos
    print('Guardando cuenta:');
    print('Nombre: ${accountName.value}');
    print('Saldo: ${currentBalance.value}');
    print('Moneda: ${currency.value}');
    print('Tipo: ${accountType.value}');
    print('Excluir de estadísticas: ${excludeFromStats.value}');

    // Más adelante se conectará con el servicio
    // Mostrar mensaje de éxito
    Get.snackbar(
      'Éxito',
      'Cuenta creada correctamente',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Volver atrás
    Navigator.pop(context);
  }
}