import 'package:flutter/material.dart';

class SeleccionarTipoCuentaModal extends StatelessWidget {
  final String selectedType;
  final Function(String) onSelect;

  // Lista de tipos de cuenta hardcodeada (más adelante desde BD)
  static const List<Map<String, dynamic>> tiposCuenta = [
    {
      'name': 'General',
      'icon': Icons.layers_outlined,
    },
    {
      'name': 'Efectivo',
      'icon': Icons.account_balance_wallet_outlined,
    },
    {
      'name': 'Cuenta corriente',
      'icon': Icons.account_balance_outlined,
    },
    {
      'name': 'Tarjeta de crédito',
      'icon': Icons.credit_card,
    },
    {
      'name': 'Cuenta de ahorros',
      'icon': Icons.savings_outlined,
    },
    {
      'name': 'Bono',
      'icon': Icons.auto_awesome_outlined,
    },
    {
      'name': 'Seguro',
      'icon': Icons.shield_outlined,
    },
    {
      'name': 'Inversión',
      'icon': Icons.trending_up,
    },
    {
      'name': 'Préstamo',
      'icon': Icons.local_atm_outlined,
    },
    {
      'name': 'Hipoteca',
      'icon': Icons.home_outlined,
    },
    {
      'name': 'Cuenta con sobregiro',
      'icon': Icons.account_balance_wallet,
    },
  ];

  const SeleccionarTipoCuentaModal({
    super.key,
    required this.selectedType,
    required this.onSelect,
  });

  static void show({
    required BuildContext context,
    required String selectedType,
    required Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SeleccionarTipoCuentaModal(
          selectedType: selectedType,
          onSelect: onSelect,
        );
      },
    );
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
        final isSelected = tipo['name'] == selectedType;

        return InkWell(
          onTap: () {
            onSelect(tipo['name']);
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
                    tipo['icon'],
                    size: 20,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 12),
                // Nombre del tipo
                Expanded(
                  child: Text(
                    tipo['name'],
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