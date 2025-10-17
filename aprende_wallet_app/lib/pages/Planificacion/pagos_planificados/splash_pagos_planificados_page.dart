import 'package:flutter/material.dart';
import 'package:aprende_wallet_app/components/splash_info_page.dart';

class SplashPagosPlanificadosPage extends StatelessWidget {
  const SplashPagosPlanificadosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Image.asset('assets/images/Logo.png', width: 40, height: 40),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: SplashInfoPage(
        pageTitle: 'Pagos Planificados',
        imagePath: 'assets/images/pagos_planificados.png',
        title: 'Ten tus próximos pagos en un solo lugar',
        subtitle:
            'Visualiza y organiza todos los pagos que planeas realizar, mantén el control de tus fechas y montos.',
        buttonText: 'Agregar pago planificado',
        onButtonPressed: () {
          Navigator.pushReplacementNamed(context, '/pagosplanificados');
        },
      ),
    );
  }
}
