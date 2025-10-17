import 'package:aprende_wallet_app/components/navBar.dart';
import 'package:aprende_wallet_app/pages/Home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'historial_gastos_controller.dart';

class HistorialGastosPage extends StatelessWidget {
  final HistorialGastosController controller = Get.put(
    HistorialGastosController(),
  );
  final HomeController homeControl = Get.find(); // Para el bottom nav

  HistorialGastosPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.cargarHistorial(); // Cargar datos al entrar

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: true, // permite botón atrás
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Historial de Gastos',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.cargando.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.listaGastos.isEmpty) {
            return const Center(child: Text("No hay gastos registrados."));
          }

          // Creamos cards dinámicos dentro de Column + ListView si quieres scroll
          return ListView.builder(
            itemCount: controller.listaGastos.length,
            itemBuilder: (context, index) {
              final gasto = controller.listaGastos[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.receipt_long, color: Colors.blue),
                  title: Text(
                    gasto.descripcion,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("${gasto.categoria} • ${gasto.fecha}"),
                  trailing: Text(
                    "S/ ${gasto.monto.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    // Puedes agregar acción al tocar un gasto si quieres
                  },
                ),
              );
            },
          );
        }),
      ),
      bottomNavigationBar: Obx(
        () => CustomBottomNavBar(
          currentIndex: homeControl.currentNavIndex.value,
          onTap: (index) => homeControl.changeNavIndex(index, context),
        ),
      ),
    );
  }
}
