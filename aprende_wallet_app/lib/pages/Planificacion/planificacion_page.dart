import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aprende_wallet_app/components/navBar.dart';
import 'planificacion_controller.dart';
import '../Home/home_controller.dart'; // <-- agregar

class PlanificacionPage extends StatelessWidget {
  final PlanificacionController control = Get.put(PlanificacionController());
  final HomeController homeControl = Get.find<HomeController>(); // <-- agregar

  PlanificacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Planificación',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCard(
              context,
              title: 'Pagos Planificados',
              subtitle: 'Tus Pagos Futuros',
              icon: Icons.calendar_today_outlined,
              color: Colors.teal,
              onTap: () => control.irAPagosPlanificados(context),
            ),
            const SizedBox(height: 16),
            _buildCard(
              context,
              title: 'Presupuestos',
              subtitle: 'Tu Plan de Gastos',
              icon: Icons.savings_outlined,
              color: Colors.amber[700]!,
              onTap: () => control.irAPresupuestos(context),
            ),
          ],
        ),
      ),
      // Mantiene la barra inferior
      bottomNavigationBar: 
      Obx(
        () => CustomBottomNavBar(
          currentIndex: homeControl.currentNavIndex.value,
          onTap: (index) => homeControl.changeNavIndex(index, context),
        ),
      ),
    );
  }

  // --- Tarjetas personalizadas ---
  Widget _buildCard(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }
}
