import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Home/home_controller.dart';
import '../../Services/registros_service.dart';
import '../../Services/categorias_service.dart';
import '../../Services/cuentas_service.dart';

class AgregarRegistroController extends GetxController {
  RxString tipo = 'Gasto'.obs; // 'Gasto' o 'Ingreso'
  RxString moneda = 'PEN'.obs;
  RxDouble monto = 0.0.obs;
  RxString cuenta = ''.obs;
  RxString categoria = ''.obs;
  Rx<DateTime> fechaHora = DateTime.now().obs;

  // IDs necesarios para el backend
  RxInt idCuenta = 0.obs;
  RxInt idCategoria = 0.obs;

  // Loading state
  RxBool isLoading = false.obs;

  // User ID (debería venir de sesión)
  // User ID (debería venir de sesión)
  // final int userId = 1; // REMOVED HARDCODED

  // Listas de catálogos desde el backend
  RxList<Map<String, dynamic>> categorias = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> cuentas = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    cargarCatalogos();
  }

  Future<int> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id') ?? -1;
  }

  Future<void> cargarCatalogos() async {
    try {
      final userId = await _getUserId();

      // Cargar categorías
      final categoriasResponse = await CategoriasService.listarCategorias(
        userId,
      );
      categorias.value = categoriasResponse;

      // Cargar cuentas
      final cuentasResponse = await CuentasService.listarCuentas(userId);
      cuentas.value = cuentasResponse;
    } catch (e) {
      print('Error al cargar catálogos: $e');
    }
  }

  void setTipo(String nuevoTipo) {
    tipo.value = nuevoTipo;
  }

  void setMonto(double nuevoMonto) {
    monto.value = nuevoMonto;
  }

  void setCuenta(String nuevaCuenta, {int? id}) {
    cuenta.value = nuevaCuenta;
    if (id != null) idCuenta.value = id;
  }

  void setCategoria(String nuevaCategoria, {int? id}) {
    categoria.value = nuevaCategoria;
    if (id != null) idCategoria.value = id;
  }

  void setFechaHora(DateTime nuevaFechaHora) {
    fechaHora.value = nuevaFechaHora;
  }

  Future<void> guardarRegistro() async {
    // Validar datos
    if (monto.value <= 0) {
      Get.snackbar(
        'Error',
        'El monto debe ser mayor a 0',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (idCuenta.value == 0 || idCategoria.value == 0) {
      Get.snackbar(
        'Error',
        'Debes seleccionar una cuenta y una categoría',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    try {
      // Determinar tipo de transacción: 1 = gasto, 2 = ingreso
      final idTipoTransaccion = tipo.value == 'Ingreso' ? 2 : 1;

      // Formatear fecha para el backend (YYYY-MM-DD HH:MM:SS)
      final fechaFormateada =
          '${fechaHora.value.year.toString().padLeft(4, '0')}-'
          '${fechaHora.value.month.toString().padLeft(2, '0')}-'
          '${fechaHora.value.day.toString().padLeft(2, '0')} '
          '${fechaHora.value.hour.toString().padLeft(2, '0')}:'
          '${fechaHora.value.minute.toString().padLeft(2, '0')}:'
          '${fechaHora.value.second.toString().padLeft(2, '0')}';

      // Crear registro en el backend
      await RegistrosService.crearRegistro(
        idUsuario: await _getUserId(),
        idCuenta: idCuenta.value,
        idCategoria: idCategoria.value,
        idTipoTransaccion: idTipoTransaccion,
        monto: monto.value,
        fechaHora: fechaFormateada,
      );

      // Recargar datos en HomeController
      try {
        final homeController = Get.find<HomeController>();
        await homeController.cargarRegistros();
        await homeController.cargarCuentas(); // Actualizar saldos
      } catch (e) {
        print('HomeController no encontrado: $e');
      }

      // Mostrar mensaje de éxito
      Get.snackbar(
        'Éxito',
        'Registro guardado correctamente',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Limpiar valores tras guardar
      tipo.value = 'Gasto';
      moneda.value = 'PEN';
      cuenta.value = '';
      categoria.value = '';
      fechaHora.value = DateTime.now();
      monto.value = 0.0;
      idCuenta.value = 0;
      idCategoria.value = 0;
    } catch (e) {
      print('Error al guardar registro: $e');
      Get.snackbar(
        'Error',
        'No se pudo guardar el registro: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
