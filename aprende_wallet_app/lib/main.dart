import 'package:aprende_wallet_app/configs/theme.dart';
import 'package:aprende_wallet_app/pages/log_in/log_in_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = ThemeData(useMaterial3: true).textTheme;
    final mt = MaterialTheme(baseTextTheme);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,

      theme: mt.light(),
      darkTheme: mt.dark(),

      highContrastTheme: mt.lightHighContrast(),
      highContrastDarkTheme: mt.darkHighContrast(),
      
      home: LogInPage()
    );
  }
}
