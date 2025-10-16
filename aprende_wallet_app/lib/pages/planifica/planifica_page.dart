import 'package:flutter/material.dart';

class PlanificaPage extends StatelessWidget {
  const PlanificaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: body(context),
      bottomNavigationBar: null 
    );
  }

  SafeArea body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono superior
            Center(
              child: Image.asset('assets/images/Logo.png', height: 80,),
            ),
            const SizedBox(height: 24),
            
            // Título
            Text(
              'Planificación',
              style: Theme.of(context).textTheme.displayMedium
            ),
            const SizedBox(height: 32),
            
            // Tarjeta: Pagos Planificados
            _buildOptionCard(
              context: context,
              title: 'Pagos Planificados',
              subtitle: 'Tus Pagos Futuros',
              imgURL: 'assets/images/Planifica.png',
              onTap: () {
                Navigator.pushNamed(context, '/planifica/pagos_planificados');
              },
            ),
            const SizedBox(height: 16),
            
            // Tarjeta: Presupuestos
            _buildOptionCard(
              context: context,
              title: 'Presupuestos',
              subtitle: 'Tu Plan de Gastos',
              imgURL: 'assets/images/Presupuesto.png',
              onTap: () {
                Navigator.pushNamed(context, '/planifica/presupuestos');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String imgURL,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 60,
              height: 60,
              child: Image.asset(imgURL),
            ),
          ],
        ),
      ),
    );
  }
}