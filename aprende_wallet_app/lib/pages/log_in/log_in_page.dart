import 'package:flutter/material.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: log_in_body(context),
    );
  }

  Widget log_in_body(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: ListView(
        
          children: [
            title(context),
            log_in_form(context),
            no_account_button(context)
          ],
        ),
      ),
    );
  }

  Column title(BuildContext context) {
    return Column(
            children: [
              Image.asset('assets/images/logo.png'),
              Text('AprendeWallet', style: Theme.of(context).textTheme.headlineMedium),
              Text(
                'Inicio Sesión',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: Theme.of(context).textTheme.headlineLarge?.fontWeight,
                  fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize
                ),
              ),
            ],
          );
  }
  
  Widget log_in_form(BuildContext context) {
    return Placeholder();
  }
  
  Widget no_account_button(BuildContext context) {
    return Placeholder();
  }
}
