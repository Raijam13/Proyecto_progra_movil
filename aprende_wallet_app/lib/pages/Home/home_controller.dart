import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Controla si se muestra la lista completa de registros
  RxBool mostrarTodosRegistros = false.obs;
  // Índice activo del bottom nav bar
  RxInt currentNavIndex = 0.obs;

  // Lista de cuentas (hardcodeado por ahora)
  RxList<Map<String, dynamic>> accounts = <Map<String, dynamic>>[
    {
      'name': 'EFECTIVO',
      'amount': 70.00,
      'currency': 'PEN',
      'icon': 'wallet',
    },
  ].obs;

  // Lista de transacciones (ahora vacía, se llenará al guardar)
  RxList<Map<String, dynamic>> transactions = <Map<String, dynamic>>[].obs;

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
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'hoy';
    }
    // Ejemplo: 5 de octubre
    return '${date.day} de ${_nombreMes(date.month)}';
  }

  String _nombreMes(int mes) {
    const nombres = [
      '', 'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
      'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
    ];
    return nombres[mes];
  }

  // Método para cambiar el índice del nav bar
  void changeNavIndex(int index, BuildContext context) {
    currentNavIndex.value = index;
    // Navegación al presionar el botón central (+)
    if (index == 2) {
      Navigator.pushNamed(context, '/agregar-registro');
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