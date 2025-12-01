import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aprende_wallet_app/components/splash_info_page.dart';
import 'package:aprende_wallet_app/models/pago_planificado_model.dart';
import 'package:intl/intl.dart';
import 'pagos_planificados_controller.dart';
import 'agregar_pago_planificado_controller.dart';

class PagosPlanificadosPage extends StatelessWidget {
  const PagosPlanificadosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<PagosPlanificadosController>()
        ? Get.find<PagosPlanificadosController>()
        : Get.put(PagosPlanificadosController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagos Planificados'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 30),
            onPressed: () {
              Get.delete<AgregarPagoPlanificadoController>();
              Get.toNamed('/agregar-pago-planificado');
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.pagosList.isEmpty) {
          return RefreshIndicator(
            onRefresh: () async => controller.fetchPagosPlanificados(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                child: _buildEmptyState(),
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => controller.fetchPagosPlanificados(),
          child: _buildPagosList(controller),
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    return SplashInfoPage(
      imagePath: 'assets/images/pagos_planificados.png',
      title: 'Ten tus próximos pagos en un solo lugar',
      subtitle:
          'Visualiza y organiza todos los pagos que planeas realizar, mantén el control de tus fechas y montos.',
      buttonText: 'Agregar pago planificado',
      onButtonPressed: () => Get.toNamed('/agregar-pago-planificado'),
    );
  }

  Widget _buildPagosList(PagosPlanificadosController controller) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.pagosList.length,
      itemBuilder: (context, index) {
        final pago = controller.pagosList[index];
        final esGasto = pago.tipo == 'gasto';
        final formatoFecha = DateFormat('dd MMM yyyy', 'es_ES');

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            onTap: () {
              Get.delete<AgregarPagoPlanificadoController>();
              Get.toNamed('/agregar-pago-planificado', arguments: pago);
            },
            leading: Icon(
              esGasto ? Icons.arrow_circle_up : Icons.arrow_circle_down,
              color: esGasto ? Colors.red : Colors.green,
            ),
            title: Text(pago.nombre),
            subtitle: Text(
              'Próximo: ${formatoFecha.format(pago.proximaFecha)} - ${pago.periodo}',
            ),
            trailing: Text(
              '${esGasto ? '-' : '+'}S/ ${pago.monto.toStringAsFixed(2)}',
              style: TextStyle(
                color: esGasto ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
