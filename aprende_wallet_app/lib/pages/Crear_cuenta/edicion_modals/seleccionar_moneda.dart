import 'package:flutter/material.dart';
import '../../../Services/monedas_service.dart';

class SeleccionarMonedaModal {
  static void show({
    required BuildContext context,
    required String selectedCurrency,
    required Function(String code) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _SeleccionarMonedaContent(
          selectedCurrency: selectedCurrency,
          onSelect: onSelect,
        );
      },
    );
  }
}

class _SeleccionarMonedaContent extends StatefulWidget {
  final String selectedCurrency;
  final Function(String code) onSelect;

  const _SeleccionarMonedaContent({
    required this.selectedCurrency,
    required this.onSelect,
  });

  @override
  State<_SeleccionarMonedaContent> createState() => _SeleccionarMonedaContentState();
}

class _SeleccionarMonedaContentState extends State<_SeleccionarMonedaContent> {
  List<Map<String, dynamic>> monedas = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _cargarMonedas();
  }

  Future<void> _cargarMonedas() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await MonedasService.listarMonedas();
      setState(() {
        monedas = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error al cargar monedas: $e';
        isLoading = false;
      });
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
          const Divider(height: 1, thickness: 8, color: Color(0xFFF5F5F5)),
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
          else if (monedas.isEmpty)
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.money_off, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('No hay monedas disponibles', textAlign: TextAlign.center),
                  ],
                ),
              ),
            )
          else
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
        final isSelected = moneda['code'] == widget.selectedCurrency;

        return InkWell(
          onTap: () {
            widget.onSelect(moneda['code'] as String);
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
                        moneda['code'] as String,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        moneda['nombre'] as String,
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