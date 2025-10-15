import 'package:flutter/material.dart';

class PagosPlanificadosPage extends StatelessWidget {
  const PagosPlanificadosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pagos planificados',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagen representativa
            Image.asset(
              'assets/images/pagos_planificados.png',
              height: 180,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 32),

            // Título y descripción
            const Text(
              'Ten tus próximos pagos en un solo lugar',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Visualiza y organiza todos los pagos que planeas realizar, mantén el control de tus fechas y montos.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 32),

            // Botón principal
            ElevatedButton(
              onPressed: () {
                // Acción futura para agregar un pago planificado
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Agregar pago planificado',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
