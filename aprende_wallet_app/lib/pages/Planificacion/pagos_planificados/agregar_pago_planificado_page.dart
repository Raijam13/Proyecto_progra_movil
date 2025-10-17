import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'agregar_pago_planificado_controller.dart';

class AgregarPagoPlanificadoPage extends StatelessWidget {
  const AgregarPagoPlanificadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AgregarPagoPlanificadoController());
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
        title: const Text('Pago Planificado',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(controller, colorScheme),
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
      BuildContext context, AgregarPagoPlanificadoController controller) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Obx(() => _buildListItem(
                context: context,
                icon: Icons.drive_file_rename_outline,
                title: 'Nombre del pago',
                trailing: controller.nombre.value.isEmpty
                    ? 'Requerido'
                    : controller.nombre.value,
                trailingColor:
                    controller.nombre.value.isEmpty ? Colors.red : Colors.grey,
                onTap: () => controller.editarNombre(context),
              )),
          _buildDivider(),
          _buildListItem(
            context: context,
            icon: Icons.category_outlined,
            title: 'Categoría',
            trailing: 'Requerido',
            trailingColor: Colors.red,
            onTap: () => controller.seleccionarCategoria(context),
          ),
          _buildDivider(),
          Obx(() => _buildListItem(
                context: context,
                icon: Icons.access_time,
                title: 'Periodo',
                trailing: controller.periodo.value,
                onTap: () => controller.seleccionarPeriodo(context),
              )),
          _buildDivider(),
          _buildListItem(
            context: context,
            icon: Icons.account_balance_wallet_outlined,
            title: 'Cuenta',
            trailing: 'Requerido',
            trailingColor: Colors.red,
            onTap: () => controller.seleccionarCuenta(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(
      AgregarPagoPlanificadoController controller, ColorScheme colorScheme) {
    return Obx(() {
      bool esGasto = controller.tipo.value == 'gasto';
      return Container(
        color: esGasto ? Colors.red.shade400 : Colors.green.shade400,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTipoSelector(controller, colorScheme),
            const SizedBox(height: 16),
            _buildMontoInput(controller),
          ],
        ),
      );
    });
  }

  Widget _buildTipoSelector(
      AgregarPagoPlanificadoController controller, ColorScheme colorScheme) {
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(value: 'gasto', label: Text('Gasto')),
        ButtonSegment(value: 'ingreso', label: Text('Ingreso')),
      ],
      selected: {controller.tipo.value},
      onSelectionChanged: (newSelection) {
        controller.setTipo(newSelection.first);
      },
      style: SegmentedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.2),
        foregroundColor: Colors.white,
        selectedForegroundColor:
            controller.tipo.value == 'gasto' ? Colors.red : Colors.green,
        selectedBackgroundColor: Colors.white,
      ),
    );
  }

  Widget _buildMontoInput(AgregarPagoPlanificadoController controller) {
    return TextField(
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontSize: 48, fontWeight: FontWeight.w300),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: const InputDecoration(
        hintText: '0.00',
        hintStyle: TextStyle(color: Colors.white54),
        border: InputBorder.none,
        prefixText: 'S/ ',
        prefixStyle: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.w300),
      ),
      onChanged: (value) => controller.setMonto(double.tryParse(value) ?? 0.0),
    );
  }

  Widget _buildListItem(
      {required BuildContext context,
      required IconData icon,
      required String title,
      required String trailing,
      Color? trailingColor,
      required VoidCallback onTap}) {
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
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400)),
            ),
            Text(
              trailing,
              style: TextStyle(
                  fontSize: 16, color: trailingColor ?? Colors.grey[600]),
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

  Widget _buildSaveButton(AgregarPagoPlanificadoController controller) {
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
                : () => controller.guardarPagoPlanificado(),
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