import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sign_up_controller.dart';

class SignUpPage extends StatelessWidget {
  final SignUpController control = Get.put(SignUpController());

  SignUpPage({super.key});

  Widget _background(BuildContext context) {
    return Container(color: const Color(0xFFF9F9F9));
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
                'Crear cuenta',
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

  Widget _infoText() {
    return SizedBox(
      width: 310,
      height: 32,
      child: Text(
        'Necesitamos alguna información de ti',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: const Color(0xFF21205B),
          fontSize: 18,
          fontFamily: 'Hind Jalandhar',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _nameField() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 152,
          height: 50,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFFD4D4D4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          child: TextFormField(
            controller: control.firstName,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20, top: 16),
              hintText: 'Nombre(s)',
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
        const SizedBox(width: 10),
        Container(
          width: 150,
          height: 48,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFFD4D4D4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          child: TextFormField(
            controller: control.lastName,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20, top: 15),
              hintText: 'Apellidos',
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
      ],
    );
  }

  Widget _emailField() {
    return Container(
      width: 310,
      height: 50,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFFD4D4D4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
      child: TextFormField(
        controller: control.email,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 20, top: 16),
          hintText: 'Correo electronico',
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
    );
  }

  Widget _passwordField() {
    return Container(
      width: 310,
      height: 50,
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
          contentPadding: EdgeInsets.only(left: 20, top: 16),
          hintText: 'Contraseña',
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
    );
  }

  Widget _confirmPasswordField() {
    return Container(
      width: 310,
      height: 50,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFFD4D4D4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
      child: TextFormField(
        controller: control.confirmPassword,
        obscureText: true,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 20, top: 16),
          hintText: 'Comprobar contraseña',
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
    );
  }

  Widget _verifyButton(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            control.registrarUsuario(context);
          },
          child: Container(
            width: 310,
            height: 60,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFF1B3A46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: const Center(
              child: Text(
                'Registrar',
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

  Widget _backToLogin() {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
        child: SizedBox(
          width: 229,
          height: 30,
          child: Text(
            'Regresar al inicio de sesión',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF121515),
              fontSize: 16,
              fontFamily: 'Hind',
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  Widget _formFields(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _infoText(),
        const SizedBox(height: 10),
        _nameField(),
        const SizedBox(height: 10),
        _emailField(),
        const SizedBox(height: 10),
        _passwordField(),
        const SizedBox(height: 10),
        _confirmPasswordField(),
        const SizedBox(height: 30),
        _verifyButton(context),
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
            const SizedBox(height: 65),
            _formFields(context),
            const SizedBox(height: 65),
            _backToLogin(),
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
          Center(child: _foreground(context)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: null,
      body: _buildBody(context),
    );
  }
}
