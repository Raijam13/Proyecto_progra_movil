import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aprende_wallet_app/components/splash_info_page.dart';
import 'package:aprende_wallet_app/models/presupuesto_model.dart';
import 'presupuestos_controller.dart';

class PresupuestosPage extends StatelessWidget {
  const PresupuestosPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final PresupuestosController controller = Get.put(PresupuestosController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Planificación', style: Theme.of(context).textTheme.bodyMedium),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 30),
            onPressed: () {
              // TODO: Navegar a la pantalla de agregar presupuesto
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.presupuestosList.isEmpty) {
          return _buildEmptyState(controller);
        }

        return _buildPresupuestosList(controller);
      }),
    );
  }

  /// Widget para mostrar cuando no hay presupuestos.
  Widget _buildEmptyState(PresupuestosController controller) {
    return SplashInfoPage(
      imagePath: 'assets/images/presupuestos_logo.png',
      imageHeight: 180,
      title: 'Crea tu primer presupuesto',
      subtitle:
          'Define tus metas de gasto y controla mejor tus finanzas asignando límites a tus categorías.',
      buttonText: 'Agregar presupuesto',
      onButtonPressed: () {
        // TODO: Navegar a la pantalla de agregar presupuesto
      },
    );
  }

  /// Widget para mostrar la lista de presupuestos.
  Widget _buildPresupuestosList(PresupuestosController controller) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.presupuestosList.length,
      itemBuilder: (context, index) {
        final Presupuesto presupuesto = controller.presupuestosList[index];
        final double progreso = presupuesto.montoGastado / presupuesto.montoTotal;

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            leading: const Icon(Icons.pie_chart_outline), // Placeholder, podrías mapear `presupuesto.icono` a un IconData real
            title: Text(presupuesto.nombre),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('S/ ${presupuesto.montoGastado.toStringAsFixed(2)} de S/ ${presupuesto.montoTotal.toStringAsFixed(2)}'),
                const SizedBox(height: 4),
                LinearProgressIndicator(value: progreso),
              ],
            ),
          ),
        );
      },
    );
  }
}