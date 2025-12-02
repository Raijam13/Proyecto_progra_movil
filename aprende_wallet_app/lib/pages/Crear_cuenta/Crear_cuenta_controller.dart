import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Crear_cuenta/edicion_modals/editar_nombre_cuenta.dart';
import '../Crear_cuenta/edicion_modals/editar_saldo_cuenta.dart';
import '../Crear_cuenta/edicion_modals/seleccionar_moneda.dart';
import '../Crear_cuenta/edicion_modals/seleccionar_tipo_cuenta.dart';
import '../../Services/cuentas_service.dart';
import '../Home/home_controller.dart';

class CrearCuentaController extends GetxController {
  // Campos de la cuenta
  RxString accountName = 'Mi cuenta'.obs;
  RxDouble currentBalance = 0.00.obs;
  RxString currency = 'PEN'.obs;
  RxString accountType = 'Efectivo'.obs;
  
  // Toggle de acciones
  RxBool excludeFromStats = false.obs;
  
  // Loading state
  RxBool isLoading = false.obs;
  
  // User ID (desde SharedPreferences)
  late int userId;

  @override
  void onInit() {
    super.onInit();
    _initUserId();
  }

  Future<void> _initUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id') ?? -1;
    final userEmail = prefs.getString('user_email') ?? 'no email';
    print("🏦 CrearCuentaController initialized with userId: $userId (email: $userEmail)");
    
    if (userId == -1) {
      print("⚠️ No hay userId en SharedPreferences al crear cuenta");
    }
  }

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
  Future<void> saveAccount(BuildContext context) async {
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

    isLoading.value = true;
    try {
      // Crear cuenta en el backend
      await CuentasService.crearCuenta(
        nombre: accountName.value,
        saldo: currentBalance.value,
        idUsuario: userId,
        codeMoneda: currency.value,
        tipoCuenta: accountType.value,
      );

      // Recargar las cuentas en el HomeController
      try {
        final homeController = Get.find<HomeController>();
        await homeController.cargarCuentas();
        await homeController.cargarBalanceTotal();
      } catch (e) {
        print('HomeController no encontrado: $e');
      }

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
    } catch (e) {
      print('Error al guardar cuenta: $e');
      Get.snackbar(
        'Error',
        'No se pudo crear la cuenta: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}