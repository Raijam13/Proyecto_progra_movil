import 'package:aprende_wallet_app/configs/theme.dart';
import 'pages/sign_in/sign_in_page.dart';
import 'package:aprende_wallet_app/pages/log_inNO/sign_up.dart';
import 'package:aprende_wallet_app/pages/splash/splash_page.dart';
import 'package:aprende_wallet_app/pages/log_inNO/bienvenida_page.dart';
import 'package:aprende_wallet_app/pages/Home/home_page.dart';
import 'package:aprende_wallet_app/pages/Crear_cuenta/Crear_cuenta_page.dart';
import 'package:aprende_wallet_app/pages/Perfil/perfil_page.dart';
import 'package:aprende_wallet_app/pages/Agregar_Registro/agregar_registro_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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

      // Agrega los delegates y locales soportados
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'), // Español
        Locale('en'), // Inglés
      ],

      initialRoute: '/home',
      routes: {
        '/': (context) => const SplashPage(),
        '/bienvenida': (context) => const BienvenidaPage(),
        '/login': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/crear-cuenta': (context) => CrearCuentaPage(),
        '/perfil': (context) => PerfilPage(),
        '/agregar-registro': (context) => AgregarRegistroPage(),
      },
    );
  }
}