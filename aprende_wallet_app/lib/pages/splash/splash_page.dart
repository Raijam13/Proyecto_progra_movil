import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, '/bienvenida');
        },
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/Logo.png', height: 400,),
              Text('AprendeWallet', style: Theme.of(context).textTheme.titleLarge,),
              Text('ULIMA', style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
      ),
    );
  }
}
