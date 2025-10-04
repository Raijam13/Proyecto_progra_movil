import 'package:flutter/material.dart';

class SeleccionarMonedaModal extends StatelessWidget {
  final String selectedCurrency;
  final Function(String) onSelect;

  // Lista de monedas hardcodeada (más adelante desde BD)
  static const List<Map<String, String>> monedas = [
    {'code': 'PEN', 'name': 'Sol Peruano'},
    {'code': 'USD', 'name': 'Dólar Estadounidense'},
    {'code': 'EUR', 'name': 'Euro'},
    {'code': 'MXN', 'name': 'Peso Mexicano'},
    {'code': 'CLP', 'name': 'Peso Chileno'},
    {'code': 'ARS', 'name': 'Peso Argentino'},
    {'code': 'COP', 'name': 'Peso Colombiano'},
    {'code': 'BRL', 'name': 'Real Brasileño'},
    {'code': 'GBP', 'name': 'Libra Esterlina'},
    {'code': 'JPY', 'name': 'Yen Japonés'},
  ];

  const SeleccionarMonedaModal({
    super.key,
    required this.selectedCurrency,
    required this.onSelect,
  });

  static void show({
    required BuildContext context,
    required String selectedCurrency,
    required Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SeleccionarMonedaModal(
          selectedCurrency: selectedCurrency,
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
          const Divider(height: 1, thickness: 8, color: Color(0xFFF5F5F5)),
          Expanded(
            child: _buildCurrencyList(context),
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
        ],
      ),
    );
  }

  Widget _buildCurrencyList(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: monedas.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        indent: 16,
        endIndent: 16,
        color: Colors.grey[200],
      ),
      itemBuilder: (context, index) {
        final moneda = monedas[index];
        final isSelected = moneda['code'] == selectedCurrency;

        return InkWell(
          onTap: () {
            onSelect(moneda['code']!);
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        moneda['code']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        moneda['name']!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}