import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
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

  // Lista de transacciones (hardcodeado por ahora)
  RxList<Map<String, dynamic>> transactions = <Map<String, dynamic>>[
    {
      'title': 'Ingreso',
      'subtitle': 'Efectivo',
      'amount': 100.00,
      'date': '27 de agosto',
      'type': 'income', // income o expense
      'color': 0xFFFFA726, // Naranja
    },
    {
      'title': 'Restaurante, comida rápida',
      'subtitle': 'Efectivo',
      'amount': -23.00,
      'date': '26 de agosto',
      'type': 'expense',
      'color': 0xFFEF5350, // Rojo
    },
    {
      'title': 'Restaurante, comida rápida',
      'subtitle': 'Efectivo',
      'amount': 3.00,
      'date': '26 de agosto',
      'type': 'income',
      'color': 0xFFEF5350, // Rojo
    },
  ].obs;

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
    print('Mostrar más transacciones');
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