import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'agregar_presupuesto_controller.dart';

class AgregarPresupuestoPage extends StatelessWidget {
  const AgregarPresupuestoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AgregarPresupuestoController controller = Get.put(
      AgregarPresupuestoController(),
    );
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancelar', style: TextStyle(color: colorScheme.primary)),
        ),
        leadingWidth: 100,
        title: Obx(
          () => Text(
            controller.isEditing.value
                ? 'Editar Presupuesto'
                : 'Agregar Presupuesto',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(() {
            if (controller.isEditing.value) {
              return IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => controller.eliminarPresupuesto(),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 10),
                _buildSectionHeader('GENERAL'),
                _buildGeneralSection(context, controller),
              ],
            ),
          ),
          _buildSaveButton(controller),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildGeneralSection(
    BuildContext context,
    AgregarPresupuestoController controller,
  ) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Obx(
            () => _buildListItem(
              context: context,
              icon: Icons.calculate_outlined,
              title: 'Monto del presupuesto',
              trailing: 'S/ ${controller.monto.value.toStringAsFixed(2)}',
              onTap: () => _mostrarDialogoMonto(context, controller),
            ),
          ),
          _buildDivider(),
          Obx(
            () => _buildListItem(
              context: context,
              icon: Icons.drive_file_rename_outline,
              title: 'Nombre del presupuesto',
              trailing: controller.nombre.value.isEmpty
                  ? 'Requerido'
                  : controller.nombre.value,
              trailingColor: controller.nombre.value.isEmpty
                  ? Colors.red
                  : Colors.grey,
              onTap: () => controller.editarNombre(context),
            ),
          ),
          _buildDivider(),
          Obx(
            () => _buildListItem(
              context: context,
              icon: Icons.access_time,
              title: 'Periodo',
              trailing: controller.periodo.value,
              onTap: () => controller.seleccionarPeriodo(context),
            ),
          ),
          _buildDivider(),
          Obx(
            () => _buildListItem(
              context: context,
              icon: Icons.category_outlined,
              title: 'Categorías',
              trailing: controller.categoria.value.isEmpty
                  ? 'Requerido'
                  : controller.categoria.value,
              trailingColor: controller.categoria.value.isEmpty
                  ? Colors.red
                  : Colors.grey,
              onTap: () => controller.seleccionarCategorias(context),
            ),
          ),
          _buildDivider(),
          Obx(
            () => _buildListItem(
              context: context,
              icon: Icons.account_balance_wallet_outlined,
              title: 'Cuentas',
              trailing: controller.cuenta.value.isEmpty
                  ? 'Todo'
                  : controller.cuenta.value,
              trailingColor: Colors.grey,
              onTap: () => controller.seleccionarCuentas(context),
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoMonto(
    BuildContext context,
    AgregarPresupuestoController controller,
  ) {
    final TextEditingController txtController = TextEditingController(
      text: controller.monto.value.toString(),
    );
    Get.defaultDialog(
      title: "Monto del Presupuesto",
      content: TextField(
        controller: txtController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(prefixText: "S/ "),
      ),
      textConfirm: "Aceptar",
      textCancel: "Cancelar",
      onConfirm: () {
        final val = double.tryParse(txtController.text) ?? 0.0;
        controller.setMonto(val);
        Get.back();
      },
    );
  }

  Widget _buildListItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String trailing,
    Color? trailingColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.grey.shade700),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              trailing,
              style: TextStyle(
                fontSize: 16,
                color: trailingColor ?? Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, color: Colors.grey[400], size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 72),
      child: Divider(height: 1, thickness: 1, color: Colors.grey[200]),
    );
  }

  Widget _buildSaveButton(AgregarPresupuestoController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Obx(
          () => ElevatedButton(
            onPressed: controller.isLoading.value
                ? null
                : () => controller.guardarPresupuesto(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Get.theme.colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: controller.isLoading.value
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : const Text('Guardar', style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
