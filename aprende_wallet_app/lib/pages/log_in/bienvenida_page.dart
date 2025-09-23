import 'package:flutter/material.dart';

class BienvenidaPage extends StatelessWidget {
  const BienvenidaPage({super.key});

  void onPressed(BuildContext context){
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: bienvenida_body(context),
    );
  }
  
  Widget bienvenida_body(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/bienvenida.png'),
        Text('Bienvenido a'),
        Text('AprendeWallet'),
        Text('Toma el control de tu dinero, haz crecer tus ahorros y conviertete en el dueño de tu futuro'),
        Text('Cada meta empieza con un buen plan'),
        TextButton(onPressed: () => onPressed(context), child: Text('Empecemos!'))
      ],
    );
  }
}