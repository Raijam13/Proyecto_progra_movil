import 'package:aprende_wallet_app/configs/theme.dart';
import 'package:aprende_wallet_app/pages/Planificacion/pagos_planificados/pagos_planificados_page.dart';
import 'package:aprende_wallet_app/pages/Planificacion/presupuestos/presupuestos_page.dart';
import 'pages/sign_in/sign_in_page.dart';
import 'package:aprende_wallet_app/pages/log_inNO/sign_up.dart';
import 'package:aprende_wallet_app/pages/splash/splash_page.dart';
import 'package:aprende_wallet_app/pages/log_inNO/bienvenida_page.dart';
import 'package:aprende_wallet_app/pages/Home/home_page.dart';
import 'package:aprende_wallet_app/pages/Crear_cuenta/Crear_cuenta_page.dart';
import 'package:aprende_wallet_app/pages/Perfil/perfil_page.dart';
import 'package:aprende_wallet_app/pages/Agregar_Registro/agregar_registro_page.dart';
import 'package:aprende_wallet_app/pages/ChatIA/page_chat.dart';
import 'package:aprende_wallet_app/pages/Planificacion/planificacion_page.dart';
import 'package:aprende_wallet_app/pages/Planificacion/pagos_planificados/splash_pagos_planificados_page.dart';
import 'package:aprende_wallet_app/pages/Planificacion/presupuestos/splash_presupuestos_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = ThemeData(useMaterial3: true).textTheme;
    final mt = MaterialTheme(baseTextTheme);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light, // Forzar el modo claro para testear
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
      getPages: [
        GetPage(name: '/', page: () => const SplashPage()),
        GetPage(name: '/bienvenida', page: () => const BienvenidaPage()),
        GetPage(name: '/login', page: () => SignInPage()),
        GetPage(name: '/signup', page: () => SignUpPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/crear-cuenta', page: () => CrearCuentaPage()),
        GetPage(name: '/perfil', page: () => PerfilPage()),
        GetPage(name: '/agregar-registro', page: () => AgregarRegistroPage()),
        GetPage(name: '/chat-ia', page: () => ChatPage()),
        GetPage(name: '/planificacion', page: () => PlanificacionPage()),
        GetPage(name: '/splash_pagosplanificados', page: () => const SplashPagosPlanificadosPage()),
        GetPage(name: '/splash_presupuestos', page: () => const SplashPresupuestosPage()),
        GetPage(name: '/presupuestos', page: () => const PresupuestosPage()),
        GetPage(name: '/pagosplanificados', page: () => const PagosPlanificadosPage()),
      ],
    );
  }
}