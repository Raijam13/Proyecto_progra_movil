import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditarSaldoCuentaModal extends StatefulWidget {
  final double initialValue;
  final String currency;
  final Function(double) onChanged;
  final Function(double) onAccept;

  const EditarSaldoCuentaModal({
    super.key,
    required this.initialValue,
    required this.currency,
    required this.onChanged,
    required this.onAccept,
  });

  static void show({
    required BuildContext context,
    required double initialValue,
    required String currency,
    required Function(double) onChanged,
    required Function(double) onAccept,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return EditarSaldoCuentaModal(
          initialValue: initialValue,
          currency: currency,
          onChanged: onChanged,
          onAccept: onAccept,
        );
      },
    );
  }

  @override
  State<EditarSaldoCuentaModal> createState() => _EditarSaldoCuentaModalState(); 
}

class _EditarSaldoCuentaModalState extends State<EditarSaldoCuentaModal> {
  late TextEditingController amountController;
  bool isPositive = true;

  @override
  void initState() {
    super.initState();
    isPositive = widget.initialValue >= 0;
    amountController = TextEditingController(
      text: widget.initialValue.abs().toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  double getCurrentValue() {
    double value = double.tryParse(amountController.text) ?? 0.0;
    return isPositive ? value : -value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          color: Color(0xFF5A7A8A),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildToggleButtons(),
            const SizedBox(height: 40),
            _buildAmountDisplay(),
            const Spacer(),
            _buildConfirmButton(context),
            const SizedBox(height: 20),
          ],
        ),
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
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Configurar cuenta',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Saldo',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isPositive = true;
                    widget.onChanged(getCurrentValue());
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isPositive ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Positivo',
                      style: TextStyle(
                        color: isPositive ? const Color(0xFF5A7A8A) : Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isPositive = false;
                    widget.onChanged(getCurrentValue());
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: !isPositive ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Negativo',
                      style: TextStyle(
                        color: !isPositive ? const Color(0xFF5A7A8A) : Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountDisplay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Moneda
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.currency,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 20),
          // Signo y cantidad
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  isPositive ? '+' : '-',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Flexible(
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: amountController,
                      autofocus: true,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                      ],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                        hintStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 64,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        widget.onChanged(getCurrentValue());
                      },
                      onSubmitted: (value) {
                        widget.onAccept(getCurrentValue());
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildConfirmButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40),
    child: SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          widget.onAccept(getCurrentValue());
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFB8C9D3), // Color claro grisáceo
          foregroundColor: const Color(0xFF2C4A5A), // Texto oscuro
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Confirmar',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

}