import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aprende_wallet_app/components/navBar.dart';
import 'planificacion_controller.dart';
import '../Home/home_controller.dart'; // <-- agregar

class PlanificacionPage extends StatelessWidget {
  final PlanificacionController control = Get.put(PlanificacionController());
  final HomeController homeControl = Get.put(HomeController());

  PlanificacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Oculta el botón de retroceso
        title: Image.asset('assets/images/Logo.png', width: 40, height: 40),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: planifica_body(context),
      // Mantiene la barra inferior
      bottomNavigationBar: Obx(
        () => CustomBottomNavBar(
          currentIndex: homeControl.currentNavIndex.value,
          onTap: (index) => homeControl.changeNavIndex(index, context),
        ),
      ),
    );
  }

  Widget planifica_body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Planificación',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          _buildCard(
            context,
            title: 'Pagos Planificados',
            subtitle: 'Tus Pagos Futuros',
            image: 'assets/images/Planifica.png',
            onTap: () => control.irAPagosPlanificados(context),
          ),
          const SizedBox(height: 16),
          _buildCard(
            context,
            title: 'Presupuestos',
            subtitle: 'Tu Plan de Gastos',
            image: 'assets/images/Presupuesto.png',
            onTap: () => control.irAPresupuestos(context),
          ),
        ],
      ),
    );
  }

  // --- Tarjetas personalizadas ---
  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String image,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withAlpha(30),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                spacing: 6,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            Image.asset(image, width: 100, height: 100),
          ],
        ),
      ),
    );
  }
}
