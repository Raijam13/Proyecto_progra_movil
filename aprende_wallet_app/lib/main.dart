import 'package:aprende_wallet_app/configs/theme.dart';
import 'package:aprende_wallet_app/pages/Planificacion/pagos_planificados/pagos_planificados_page.dart';
import 'package:aprende_wallet_app/pages/Planificacion/presupuestos/presupuestos_page.dart';
import 'pages/sign_in/sign_in_page.dart';
import 'package:aprende_wallet_app/pages/sign_up/sign_up_page.dart';
import 'package:aprende_wallet_app/pages/splash/splash_page.dart';
import 'package:aprende_wallet_app/pages/sign_up/bienvenida_page.dart';
import 'package:aprende_wallet_app/pages/Home/home_page.dart';
import 'package:aprende_wallet_app/pages/Crear_cuenta/Crear_cuenta_page.dart';
import 'package:aprende_wallet_app/pages/Perfil/perfil_page.dart';
import 'package:aprende_wallet_app/pages/Perfil/perfil_controller.dart';
import 'package:aprende_wallet_app/pages/Agregar_Registro/agregar_registro_page.dart';
import 'package:aprende_wallet_app/pages/ChatIA/page_chat.dart';
import 'package:aprende_wallet_app/pages/Planificacion/planificacion_page.dart';
import 'package:aprende_wallet_app/pages/Planificacion/pagos_planificados/agregar_pago_planificado_page.dart';
import 'package:aprende_wallet_app/pages/Planificacion/pagos_planificados/splash_pagos_planificados_page.dart';
import 'package:aprende_wallet_app/pages/Planificacion/presupuestos/agregar_presupuesto_page.dart';
import 'package:aprende_wallet_app/pages/Planificacion/presupuestos/splash_presupuestos_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
      themeMode: ThemeMode.light,
      theme: mt.light(),
      darkTheme: mt.dark(),
      highContrastTheme: mt.lightHighContrast(),
      highContrastDarkTheme: mt.darkHighContrast(),

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
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
        '/chat-ia': (context) => ChatPage(),
        '/planificacion': (context) => PlanificacionPage(),
        '/splash_pagosplanificados': (context) =>
            SplashPagosPlanificadosPage(),
        '/splash_presupuestos': (context) => SplashPresupuestosPage(),
        '/pagosplanificados': (context) => PagosPlanificadosPage(),
        '/presupuestos': (context) => PresupuestosPage(),
        '/agregar-pago-planificado': (context) =>
            const AgregarPagoPlanificadoPage(),
        '/agregar-presupuesto': (context) => const AgregarPresupuestoPage(),
      },
    );
  }
}
