import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/sign_up_model.dart';
import '../../services/sign_up_service.dart';

class SignUpController extends GetxController {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final success = false.obs;
  final message = ''.obs;

  final SignUpService _service = SignUpService();

  Future<void> registrarUsuario(BuildContext context) async {
    final nombres = firstName.text.trim();
    final apellidos = lastName.text.trim();
    final correo = email.text.trim();
    final contrasena = password.text.trim();
    final confirmarContrasena = confirmPassword.text.trim();

    // Validaciones
    if (nombres.isEmpty || apellidos.isEmpty || correo.isEmpty || contrasena.isEmpty || confirmarContrasena.isEmpty) {
      message.value = "Por favor completa todos los campos.";
      success.value = false;
      return;
    }

    if (contrasena != confirmarContrasena) {
      message.value = "Las contraseñas no coinciden.";
      success.value = false;
      return;
    }

    final model = SignUpModel(
      nombres: nombres,
      apellidos: apellidos,
      correo: correo,
      contrasena: contrasena,
    );

    final response = await _service.registrarUsuario(model);

    success.value = response["success"];
    message.value = response["message"];

    if (success.value) {
      // Redirigir al login después de registro exitoso
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}