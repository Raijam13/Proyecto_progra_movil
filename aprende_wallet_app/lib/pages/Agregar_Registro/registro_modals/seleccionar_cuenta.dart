import 'package:flutter/material.dart';
import '../../../Services/cuentas_service.dart';

class CuentaItem {
  final int id;
  final String nombre;
  final IconData icono;
  final double saldo;
  final String moneda;
  
  CuentaItem({
    required this.id,
    required this.nombre,
    required this.icono,
    required this.saldo,
    required this.moneda,
  });
}

class SeleccionarCuentaModal {
  // Mapeo de iconos según el tipo de cuenta
  static IconData _getIconForAccount(String tipo) {
    final tipoLower = tipo.toLowerCase();
    if (tipoLower.contains('efectivo')) return Icons.attach_money;
    if (tipoLower.contains('banco') || tipoLower.contains('corriente')) return Icons.account_balance;
    if (tipoLower.contains('crédito') || tipoLower.contains('credito')) return Icons.credit_card;
    if (tipoLower.contains('ahorro')) return Icons.savings;
    if (tipoLower.contains('inversión') || tipoLower.contains('inversion')) return Icons.scatter_plot;
    if (tipoLower.contains('préstamo') || tipoLower.contains('prestamo')) return Icons.attach_money;
    if (tipoLower.contains('hipoteca')) return Icons.home;
    return Icons.account_balance_wallet; // Icono por defecto
  }

  static Future<void> show({
    required BuildContext context,
    required Function(String nombre, int id) onSelect, // Ahora devuelve nombre e id
    String? initialCuenta,
    required int userId,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return _SeleccionarCuentaContent(
          onSelect: onSelect,
          initialCuenta: initialCuenta,
          userId: userId,
        );
      },
    );
  }
}

class _SeleccionarCuentaContent extends StatefulWidget {
  final Function(String nombre, int id) onSelect;
  final String? initialCuenta;
  final int userId;

  const _SeleccionarCuentaContent({
    required this.onSelect,
    this.initialCuenta,
    required this.userId,
  });

  @override
  State<_SeleccionarCuentaContent> createState() => _SeleccionarCuentaContentState();
}

class _SeleccionarCuentaContentState extends State<_SeleccionarCuentaContent> {
  List<CuentaItem> cuentas = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _cargarCuentas();
  }

  Future<void> _cargarCuentas() async {
    try {
      final response = await CuentasService.listarCuentas(widget.userId);
      setState(() {
        cuentas = response.map((c) {
          return CuentaItem(
            id: c['id'] as int,
            nombre: c['name'] as String,
            saldo: (c['amount'] as num).toDouble(),
            moneda: c['currency'] as String? ?? 'PEN',
            icono: SeleccionarCuentaModal._getIconForAccount(c['type'] as String? ?? ''),
          );
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error al cargar cuentas: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            )
          else if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red[700]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else if (cuentas.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(Icons.account_balance_wallet_outlined, size: 48, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No tienes cuentas creadas',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ],
              ),
            )
          else
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cuentas.length,
                itemBuilder: (context, index) {
                  final cuenta = cuentas[index];
                  return ListTile(
                    leading: Icon(cuenta.icono, color: Colors.grey[600]),
                    title: Text(cuenta.nombre, style: const TextStyle(fontSize: 16)),
                    subtitle: Text(
                      '${cuenta.moneda} ${cuenta.saldo.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    onTap: () {
                      widget.onSelect(cuenta.nombre, cuenta.id);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
