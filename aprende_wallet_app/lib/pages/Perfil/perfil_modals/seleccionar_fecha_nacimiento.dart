import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SeleccionarFechaNacimientoModal {
  static Future<void> show({
    required BuildContext context,
    required Function(String) onSelect,
    String? initialDate,
  }) async {
    DateTime? selectedDate;
    
    // Si hay fecha inicial, parsearla
    if (initialDate != null && initialDate != 'No especificado') {
      try {
        selectedDate = DateFormat('dd/MM/yyyy').parse(initialDate);
      } catch (e) {
        selectedDate = null;
      }
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      locale: const Locale('es', 'ES'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Formatear la fecha seleccionada
      final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      onSelect(formattedDate);
    }
  }
}