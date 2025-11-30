import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Services/cuentas_service.dart';
import '../../Services/registros_service.dart';
import '../../Services/dashboard_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  // Controla si se muestra la lista completa de registros
  RxBool mostrarTodosRegistros = false.obs;
  // Índice activo del bottom nav bar
  RxInt currentNavIndex = 0.obs;
  // Loading state
  RxBool isLoading = false.obs;
  // User ID (hardcodeado por ahora, debería venir de sesión)
  //final int userId = 1;
  late int userId;

  // Lista de cuentas (ahora desde el backend)
  RxList<Map<String, dynamic>> accounts = <Map<String, dynamic>>[].obs;

  // Lista de transacciones (desde el backend)
  RxList<Map<String, dynamic>> transactions = <Map<String, dynamic>>[].obs;

  // Balance total
  RxDouble totalBalance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _initUserId();
  }

  Future<void> _initUserId() async {
    await refreshUser();
  }

  Future<void> refreshUser() async {
    final prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('user_id');

    // Retry mechanism for race conditions
    if (id == null || id == -1) {
      await Future.delayed(const Duration(milliseconds: 500));
      id = prefs.getInt('user_id');
    }

    userId = id ?? -1;
    print("HomeController initialized with userId: $userId");

    if (userId != -1) {
      cargarDatos();
    }
  }

  // Cargar todos los datos del backend
  Future<void> cargarDatos() async {
    if (userId == -1) return;
    isLoading.value = true;
    try {
      await Future.wait([
        cargarCuentas(),
        cargarRegistros(),
        cargarBalanceTotal(),
      ]);
    } catch (e) {
      print('Error al cargar datos: $e');
      Get.snackbar(
        'Error',
        'No se pudieron cargar los datos',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cargarCuentas() async {
    try {
      final data = await CuentasService.listarCuentas(userId);
      accounts.value = data;
    } catch (e) {
      print("Error cargando cuentas: $e");
    }
  }

  Future<void> cargarRegistros() async {
    try {
      final data = await RegistrosService.listarRegistros(userId: userId);
      transactions.value = data;
    } catch (e) {
      print("Error cargando registros: $e");
    }
  }

  // Cargar balance total desde el backend
  Future<void> cargarBalanceTotal() async {
    try {
      final response = await DashboardService.obtenerBalanceTotal(userId);
      totalBalance.value = (response['total_balance'] as num).toDouble();
    } catch (e) {
      print('Error al cargar balance total: $e');
      rethrow;
    }
  }

  // Método para agregar un registro desde AgregarRegistroController
  void agregarTransaccion({
    required String title,
    required String subtitle,
    required double amount,
    required DateTime date,
    required String type,
    required int color,
  }) {
    transactions.insert(0, {
      'title': title,
      'subtitle': subtitle,
      'amount': amount,
      'date': _formatDate(date),
      'type': type,
      'color': color,
    });
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'hoy';
    }
    // Ejemplo: 5 de octubre
    return '${date.day} de ${_nombreMes(date.month)}';
  }

  String _nombreMes(int mes) {
    const nombres = [
      '',
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];
    return nombres[mes];
  }

  // Método para cambiar el índice del nav bar
  void changeNavIndex(int index, BuildContext context) {
    currentNavIndex.value = index;

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    }

    if (index == 1) {
      Navigator.pushReplacementNamed(context, '/planificacion');
    }
    // Navegación al presionar el botón central (+)
    if (index == 2) {
      Navigator.pushNamed(context, '/agregar-registro');
    }

    if (index == 3) {
      Navigator.pushReplacementNamed(context, '/chat-ia');
      return;
    }
    if (index == 4) {
      Navigator.pushNamed(context, '/perfil');
    }
  }

  // Método para agregar una nueva cuenta
  void addAccount(BuildContext context) {
    // Por ahora solo un print, más adelante navegará a crear cuenta
    Navigator.pushNamed(context, '/crear-cuenta');
  }

  // Método para mostrar más gastos principales
  void showMoreExpenses() {
    print('Mostrar más gastos principales');
  }

  // Método para mostrar más transacciones
  void showMoreTransactions() {
    mostrarTodosRegistros.value = !mostrarTodosRegistros.value;
  }

  // Método para abrir menú de gastos principales
  void openExpensesMenu() {
    print('Abrir menú de gastos principales');
  }

  // Método para abrir menú de últimos registros
  void openTransactionsMenu() {
    print('Abrir menú de últimos registros');
  }
}
