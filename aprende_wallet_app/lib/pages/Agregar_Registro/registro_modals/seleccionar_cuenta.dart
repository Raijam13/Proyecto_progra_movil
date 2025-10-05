import 'package:flutter/material.dart';

class CuentaItem {
  final String nombre;
  final IconData icono;
  CuentaItem({required this.nombre, required this.icono});
}

class SeleccionarCuentaModal {
  static final List<CuentaItem> cuentas = [
    CuentaItem(nombre: 'General', icono: Icons.account_balance_wallet),
    CuentaItem(nombre: 'Efectivo', icono: Icons.attach_money),
    CuentaItem(nombre: 'Cuenta corriente', icono: Icons.account_balance),
    CuentaItem(nombre: 'Tarjeta de crédito', icono: Icons.credit_card),
    CuentaItem(nombre: 'Cuenta de ahorros', icono: Icons.savings),
    CuentaItem(nombre: 'Bono', icono: Icons.monetization_on),
    CuentaItem(nombre: 'Seguro', icono: Icons.security),
    CuentaItem(nombre: 'Inversión', icono: Icons.scatter_plot),
    CuentaItem(nombre: 'Préstamo', icono: Icons.attach_money),
    CuentaItem(nombre: 'Hipoteca', icono: Icons.home),
    CuentaItem(nombre: 'Cuenta con sobregiro', icono: Icons.warning),
  ];

  static Future<void> show({
    required BuildContext context,
    required Function(String) onSelect,
    String? initialCuenta,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Text('Cuentas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cuentas.length,
                  itemBuilder: (context, index) {
                    final cuenta = cuentas[index];
                    return ListTile(
                      leading: Icon(cuenta.icono, color: Colors.grey[600]),
                      title: Text(cuenta.nombre, style: const TextStyle(fontSize: 16)),
                      onTap: () {
                        onSelect(cuenta.nombre);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
