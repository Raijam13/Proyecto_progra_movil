import 'package:flutter/material.dart';
import '../../../Services/tipos_service.dart';

class SeleccionarTipoCuentaModal {
  static void show({
    required BuildContext context,
    required String selectedType,
    required Function(String nombre) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _SeleccionarTipoCuentaContent(
          selectedType: selectedType,
          onSelect: onSelect,
        );
      },
    );
  }
}

class _SeleccionarTipoCuentaContent extends StatefulWidget {
  final String selectedType;
  final Function(String nombre) onSelect;

  const _SeleccionarTipoCuentaContent({
    required this.selectedType,
    required this.onSelect,
  });

  @override
  State<_SeleccionarTipoCuentaContent> createState() => _SeleccionarTipoCuentaContentState();
}

class _SeleccionarTipoCuentaContentState extends State<_SeleccionarTipoCuentaContent> {
  List<Map<String, dynamic>> tiposCuenta = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _cargarTiposCuenta();
  }

  Future<void> _cargarTiposCuenta() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await TiposService.listarTiposCuenta();
      setState(() {
        tiposCuenta = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error al cargar tipos de cuenta: $e';
        isLoading = false;
      });
    }
  }

  IconData _getIconForTipo(String nombre) {
    switch (nombre.toLowerCase()) {
      case 'general':
        return Icons.layers_outlined;
      case 'efectivo':
        return Icons.account_balance_wallet_outlined;
      case 'cuenta corriente':
        return Icons.account_balance_outlined;
      case 'tarjeta de crédito':
        return Icons.credit_card;
      case 'cuenta de ahorros':
        return Icons.savings_outlined;
      case 'bono':
        return Icons.auto_awesome_outlined;
      case 'seguro':
        return Icons.shield_outlined;
      case 'inversión':
        return Icons.trending_up;
      case 'préstamo':
        return Icons.local_atm_outlined;
      case 'hipoteca':
        return Icons.home_outlined;
      case 'cuenta con sobregiro':
        return Icons.account_balance_wallet;
      default:
        return Icons.account_balance;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          const Divider(height: 1, thickness: 1),
          if (isLoading)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (errorMessage != null)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 8),
                    Text(errorMessage!, textAlign: TextAlign.center),
                  ],
                ),
              ),
            )
          else if (tiposCuenta.isEmpty)
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.account_balance_outlined, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('No hay tipos de cuenta disponibles', textAlign: TextAlign.center),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: _buildTypeList(context),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Configurar cuenta',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'Tipo',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeList(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: tiposCuenta.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        indent: 60,
        endIndent: 16,
        color: Colors.grey[200],
      ),
      itemBuilder: (context, index) {
        final tipo = tiposCuenta[index];
        final isSelected = tipo['nombre'] == widget.selectedType;

        return InkWell(
          onTap: () {
            widget.onSelect(tipo['nombre'] as String);
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Icono
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    _getIconForTipo(tipo['nombre'] as String),
                    size: 20,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 12),
                // Nombre del tipo
                Expanded(
                  child: Text(
                    tipo['nombre'] as String,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Check si está seleccionado
                if (isSelected)
                  Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}