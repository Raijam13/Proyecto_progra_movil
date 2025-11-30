import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Home/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/sign_in_model.dart';
import '../../Services/sign_in_service.dart';

class SignInController extends GetxController {
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    username.clear();
    password.clear();
  }

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

    success.value = response["success"] == true;
    message.value = response["message"] ?? "Error desconocido";

    if (success.value) {
      final prefs = await SharedPreferences.getInstance();

      dynamic usuario;
      if (response.containsKey("data")) {
        final data = response["data"];
        if (data is Map && data.containsKey("usuario")) {
          usuario = data["usuario"];
        } else {
          usuario = data;
        }
      } else if (response.containsKey("usuario")) {
        usuario = response["usuario"];
      }

      print(">>> DEBUG: usuario extracted: $usuario");
      if (usuario != null) {
        print(">>> DEBUG: usuario type: ${usuario.runtimeType}");
        if (usuario is Map) {
          print(">>> DEBUG: usuario keys: ${usuario.keys}");
          print(
            ">>> DEBUG: usuario['id']: ${usuario['id']} (Type: ${usuario['id']?.runtimeType})",
          );
        }
      }

      if (usuario == null) {
        print("⚠️ USUARIO ES NULL — NO SE GUARDARÁ ID");
      } else if (usuario is Map && usuario["id"] != null) {
        try {
          final int id = int.parse(usuario["id"].toString());
          await prefs.setInt("user_id", id);
          print("✅ ID de usuario guardado: $id");
        } catch (e) {
          print("⚠️ Error parsing ID: $e");
        }
      } else {
        print("⚠️ USUARIO NO TIENE ID O FORMATO INCORRECTO: $usuario");
      }

      Future.delayed(const Duration(seconds: 1), () async {
        if (Get.isRegistered<HomeController>()) {
          // Si el controlador ya existe, forzamos la recarga del usuario
          await Get.find<HomeController>().refreshUser();
        }
        Navigator.pushReplacementNamed(context, '/home');
      });
    }
  }
}
