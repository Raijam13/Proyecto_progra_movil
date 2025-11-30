import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'agregar_registro_controller.dart';
import 'registro_modals/seleccionar_fecha_y_hora.dart';
import 'registro_modals/seleccionar_cuenta.dart';
import 'registro_modals/seleccionar_categoria.dart';

// Formatea la fecha y hora para mostrar en la UI tipo "hoy, 10:09 a. m."
String _formatFechaHora(DateTime dateTime, BuildContext context) {
  final now = DateTime.now();
  final isToday =
      dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day;
  final dateLabel = isToday
      ? 'hoy'
      : MaterialLocalizations.of(context).formatShortMonthDay(dateTime);
  final time = TimeOfDay.fromDateTime(dateTime).format(context);
  return '$dateLabel, $time';
}

class AgregarRegistroPage extends StatelessWidget {
  AgregarRegistroPage({super.key});

  final AgregarRegistroController control = Get.put(
    AgregarRegistroController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Obx(
        () => Column(
          children: [
            Container(
              color: control.tipo.value == 'Gasto'
                  ? Colors.red[400]
                  : Colors.green[400],
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              control.tipo.value = 'Gasto';
                              control.moneda.value = 'PEN';
                              control.monto.value = 0.0;
                              control.cuenta.value = '';
                              control.categoria.value = '';
                              control.fechaHora.value = DateTime.now();
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Text(
                            'Agregar registro',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 80),
                        ],
                      ),
                    ),
                    _buildTipoSelector(context),
                    _buildMontoYMoneda(context),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 12, left: 0, right: 0),
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      'GENERAL',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  _buildGeneralSection(context),
                ],
              ),
            ),
            const Spacer(),
            _buildGuardarButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTipoSelector(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTipoButton('Gasto', Colors.red[400]!),
          const SizedBox(width: 16),
          _buildTipoButton('Ingreso', Colors.green[400]!),
        ],
      ),
    );
  }

  Widget _buildTipoButton(String tipo, Color color) {
    return Obx(
      () => GestureDetector(
        onTap: () => control.setTipo(tipo),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: control.tipo.value == tipo
                ? Colors.white
                : color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: control.tipo.value == tipo ? color : Colors.transparent,
              width: 2,
            ),
          ),
          child: Text(
            tipo,
            style: TextStyle(
              color: control.tipo.value == tipo ? color : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMontoYMoneda(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Obx(
              () => Text(
                control.moneda.value,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => Text(
                      control.tipo.value == 'Gasto' ? '-' : '+',
                      style: const TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Reduce spacing between sign and amount
                  const SizedBox(width: 1),
                  SizedBox(
                    width: 140,
                    child: TextField(
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '0.00',
                        hintStyle: TextStyle(
                          fontSize: 40,
                          color: Colors.white54,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        final monto = double.tryParse(value) ?? 0.0;
                        control.setMonto(monto);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralSection(BuildContext context) {
    return Column(
      children: [
        _buildGeneralItem(
          icon: Icons.account_balance_wallet_outlined,
          label: 'Cuenta',
          value: control.cuenta.value.isEmpty
              ? 'Requerido'
              : control.cuenta.value,
          valueColor: control.cuenta.value.isEmpty ? Colors.red : Colors.black,
          onTap: () async {
            await SeleccionarCuentaModal.show(
              context: context,
              // userId: control.userId, // Removed
              initialCuenta: control.cuenta.value,
              onSelect: (nombre, id) {
                control.setCuenta(nombre, id: id);
              },
            );
          },
        ),
        _buildGeneralItem(
          icon: Icons.category_outlined,
          label: 'Categoría',
          value: control.categoria.value.isEmpty
              ? 'Requerido'
              : control.categoria.value,
          valueColor: control.categoria.value.isEmpty
              ? Colors.red
              : Colors.black,
          onTap: () async {
            await SeleccionarCategoriaModal.show(
              context: context,
              initialCategoria: control.categoria.value,
              onSelect: (nombre, id) {
                control.setCategoria(nombre, id: id);
              },
            );
          },
        ),
        _buildGeneralItem(
          icon: Icons.calendar_today_outlined,
          label: 'Fecha y hora',
          value: _formatFechaHora(control.fechaHora.value, context),
          valueColor: Colors.black,
          onTap: () async {
            await SeleccionarFechaYHoraModal.show(
              context: context,
              initialDate: control.fechaHora.value,
              onSelect: (dateTime) {
                control.setFechaHora(dateTime);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildGeneralItem({
    required IconData icon,
    required String label,
    required String value,
    required Color valueColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, size: 20, color: Colors.grey[700]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Text(value, style: TextStyle(fontSize: 16, color: valueColor)),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildGuardarButton(BuildContext context) {
    final isEnabled =
        control.cuenta.value.isNotEmpty &&
        control.categoria.value.isNotEmpty &&
        control.monto.value > 0;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: ElevatedButton(
        onPressed: isEnabled ? () => control.guardarRegistro() : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? Colors.blue : Colors.grey[300],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Guardar',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
