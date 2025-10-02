import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sign_in_controller.dart';

class SignInPage extends StatelessWidget {
  final SignInController control = Get.put(SignInController());

  SignInPage({super.key});

  Widget _background(BuildContext context) {
    return Container(
      color: const Color(0xFFF9F9F9),
    );
  }

Widget _logoSection() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(
        'assets/images/Logo.png',
        width: 86,
        height: 93,
        fit: BoxFit.contain,
      ),
      const SizedBox(height: 30),
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 256,
            child: Text(
              'AprendeWallet',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF215B20),
                fontSize: 35,
                fontFamily: 'Hind Jalandhar',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 298,
            child: Text(
              'Inicio Sesión',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF1B3A46),
                fontSize: 52,
                fontFamily: 'Hind Jalandhar',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

// ... el resto de tu código se mantiene igual
Widget _emailField() {
    return Container(
      width: 301.40,
      height: 76.29,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 26,
            child: Container(
              width: 301,
              height: 50,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFFD4D4D4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
              ),
              child: TextFormField(
                controller: control.username,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 20, top: 16),
                  hintText: 'AlumnoULIMA@aloe.ulima.edu.pe',
                  hintStyle: TextStyle(
                    color: Color(0xFF191D1E),
                    fontSize: 16,
                    fontFamily: 'Karla',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: const TextStyle(
                  color: Color(0xFF191D1E),
                  fontSize: 16,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 1,
            top: 0,
            child: SizedBox(
              width: 315,
              child: Text(
                'CORREO ELECTRONICO',
                style: TextStyle(
                  color: Color(0xFF858C85),
                  fontSize: 14,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      width: 301.40,
      height: 71.03,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 26,
            child: Container(
              width: 301,
              height: 45,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFFD4D4D4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
              ),
              child: TextFormField(
                controller: control.password,
                obscureText: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 20, top: 12),
                  hintText: '••••••••',
                  hintStyle: TextStyle(
                    color: Color(0xFF191D1E),
                    fontSize: 16,
                    fontFamily: 'Karla',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2.0,
                  ),
                ),
                style: const TextStyle(
                  color: Color(0xFF191D1E),
                  fontSize: 16,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 1,
            top: 0,
            child: SizedBox(
              width: 315,
              child: Text(
                'CONTRASEÑA',
                style: TextStyle(
                  color: Color(0xFF888888),
                  fontSize: 14,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            control.login(context);
          },
          child: Container(
            width: 301.40,
            height: 49.98,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFF1B3946),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            ),
            child: const Center(
              child: Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontFamily: 'Hind',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Obx(
          () => Text(
            control.message.value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: control.success.value
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.error,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

 Widget _signUpSection(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(
        width: 222,
        height: 23,
        child: Text(
          'No tienes una cuenta?',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF2B4338),
            fontSize: 16,
            fontFamily: 'Hind',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      const SizedBox(height: 12),
      GestureDetector(
        onTap: () {
          // Navegar a SignUpPage
          Navigator.pushNamed(context, '/signup');
        },
        child: Container(
          width: 297,
          height: 50,
          decoration: ShapeDecoration(
            color: const Color(0xFF1B3A46),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          ),
          child: const Stack(
            children: [
              Center(
                child: Text(
                  'Crear una cuenta',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

  Widget _form(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _logoSection(),
          const SizedBox(height: 80),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _emailField(),
              const SizedBox(height: 20),
              _passwordField(),
              const SizedBox(height: 20),
              _loginButton(context),
            ],
          ),
          const SizedBox(height: 80),
          _signUpSection(context),
        ],
      ),
    ),
  );
}

 Widget _foreground(BuildContext context) {
  return SingleChildScrollView(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          _form(context),
        ],
      ),
    ),
  );
}

Widget _buildBody(BuildContext context) {
  return SafeArea(
    child: Stack(
      children: [
        _background(context),
        Center(
          child: _foreground(context),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: _buildBody(context),
    );
  }
}