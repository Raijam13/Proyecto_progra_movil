import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/sign_in_model.dart';
import '../../Services/sign_in_service.dart';

class SignInController extends GetxController {
  final username = TextEditingController();
  final password = TextEditingController();

  final success = false.obs;
  final message = ''.obs;

  final SignInService _service = SignInService();

  Future<void> login(BuildContext context) async {
    final correo = username.text.trim();
    final contrasena = password.text.trim();

    if (correo.isEmpty || contrasena.isEmpty) {
      message.value = "Por favor completa todos los campos.";
      success.value = false;
      return;
    }

    final model = SignInModel(correo: correo, contrasena: contrasena);
    final response = await _service.login(model);

    success.value = response["success"];
    message.value = response["message"];

    if (success.value) {
      // Aquí puedes redirigir a otra página si el login es correcto
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }
  }
}
