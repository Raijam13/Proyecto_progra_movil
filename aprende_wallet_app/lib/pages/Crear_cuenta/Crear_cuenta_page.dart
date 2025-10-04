import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Crear_cuenta_controller.dart';

class CrearCuentaPage extends StatelessWidget {
  final CrearCuentaController control = Get.put(CrearCuentaController());

  CrearCuentaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: TextButton(
          onPressed: () => control.cancel(context),
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: colorScheme.primary,
              fontSize: 16,
            ),
          ),
        ),
        leadingWidth: 100,
        title: const Text(
          'Configurar cuenta',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildSectionHeader('GENERAL'),
                  _buildGeneralSection(context),
                  const SizedBox(height: 30),
                  _buildSectionHeader('ACTIONS'),
                  _buildActionsSection(context),
                ],
              ),
            ),
          ),
          _buildSaveButton(context),
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

  Widget _buildGeneralSection(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Obx(() => _buildListItem(
                context: context,
                icon: Icons.person_outline,
                iconColor: Colors.blue,
                title: 'Nombre de la cuenta',
                trailing: control.accountName.value,
                onTap: () => control.editAccountName(context),
              )),
          _buildDivider(),
          Obx(() => _buildListItem(
                context: context,
                icon: Icons.calculate_outlined,
                iconColor: Colors.grey,
                title: 'Saldo inicial',
                trailing: control.currentBalance.value.toStringAsFixed(2),
                onTap: () => control.editCurrentBalance(context),
              )),
          _buildDivider(),
          Obx(() => _buildListItem(
                context: context,
                icon: Icons.attach_money,
                iconColor: Colors.grey,
                title: 'Moneda',
                trailing: control.currency.value,
                onTap: () => control.selectCurrency(context),
              )),
          _buildDivider(),
          Obx(() => _buildListItem(
                context: context,
                icon: Icons.account_balance_wallet_outlined,
                iconColor: Colors.grey,
                title: 'Tipo',
                trailing: control.accountType.value,
                onTap: () => control.selectAccountType(context),
              )),
        ],
      ),
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Obx(() => _buildToggleItem(
            context: context,
            icon: Icons.visibility_off_outlined,
            iconColor: Colors.grey,
            title: 'Excluir de las estadísticas',
            value: control.excludeFromStats.value,
            onChanged: (value) => control.toggleExcludeFromStats(value),
          )),
    );
  }

  Widget _buildListItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String trailing,
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
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
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
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 72),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey[200],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
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
        child: ElevatedButton(
          onPressed: () => control.saveAccount(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Guardar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}