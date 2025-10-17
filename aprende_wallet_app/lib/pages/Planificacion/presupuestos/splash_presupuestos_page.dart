import 'package:flutter/material.dart';
import 'package:aprende_wallet_app/components/splash_info_page.dart';
import 'package:get/get.dart';

class SplashPresupuestosPage extends StatelessWidget {
  const SplashPresupuestosPage({super.key});

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
        pageTitle: 'Presupuestos',
        imagePath: 'assets/images/presupuestos_logo.png',
        title: 'Crea presupuestos personalizados',
        subtitle:
            'Define tus metas de gasto y controla mejor tus finanzas asignando límites a tus categorías.',
        buttonText: 'Agregar presupuesto',
        onButtonPressed: () => Get.offNamed('/presupuestos'),
      ),
    );
  }
}
