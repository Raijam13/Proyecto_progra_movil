import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

    // Depuración: imprimir respuesta completa
    print("LOGIN RESPONSE: $response");

    success.value = response["status"] == "ok";
    message.value = response["message"] ?? "Error desconocido";

    if (success.value) {
      final prefs = await SharedPreferences.getInstance();

      final usuario = response["usuario"];

      if (usuario == null) {
        print("⚠️ USUARIO ES NULL — NO SE GUARDARÁ ID");
      } else if (usuario["id"] != null) {
        await prefs.setInt("user_id", usuario["id"]);
        print("✅ ID de usuario guardado: ${usuario["id"]}");
        print("perfil cargado tras login");
      } else {
        print("⚠️ USUARIO NO TIENE ID");
      }

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }
  }
}
