import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/perfil_service.dart';
import '../ChatIA/page_chat_controller.dart';
import '../Home/home_controller.dart';

class PerfilController extends GetxController {
  final PerfilService perfilService = PerfilService();

  // Datos del usuario
  final nombre = ''.obs;
  final apellido = ''.obs;
  final email = ''.obs;
  final genero = ''.obs;
  final fechaNacimiento = ''.obs;
  final imagenPerfil = ''.obs;

  String userId = ""; // ← cargado dinámicamente desde SharedPreferences

  @override
  void onInit() {
    super.onInit();
    Future.microtask(() async {
      await cargarUserId();
      await cargarPerfil();
    });
  }

  // ============================
  //      CARGAR ID
  // ============================
  Future<void> cargarUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final idGuardado = prefs.getInt("user_id");

    if (idGuardado == null) {
      print("⚠️ No se encontró user_id en SharedPreferences");
      return;
    }

    userId = idGuardado.toString();
    print("✅ ID cargado: $userId");
  }

  // ============================
  //      CARGAR PERFIL
  // ============================
  Future<void> cargarPerfil() async {
    try {
      if (userId.isEmpty) return;

      final data = await perfilService.obtenerPerfil(userId);
      Map<String, dynamic> usuario;

      if (data.containsKey("usuario")) {
        usuario = data["usuario"];
      } else if (data.containsKey("data") && data["data"] is Map) {
        // Si viene dentro de 'data' (formato GenericResponse)
        final innerData = data["data"];
        if (innerData.containsKey("usuario")) {
          usuario = innerData["usuario"];
        } else {
          usuario = innerData; // Asumimos que data ES el usuario
        }
      } else {
        usuario = data; // Fallback
      }

      nombre.value = usuario["nombres"] ?? "";
      apellido.value = usuario["apellidos"] ?? "";
      email.value = usuario["correo"] ?? "";
      genero.value = usuario["genero"] ?? "";
      fechaNacimiento.value = usuario["fecha_nacimiento"] ?? "";
      imagenPerfil.value = usuario["imagen_perfil"] ?? "";
    } catch (e) {
      print("❌ Error cargando perfil: $e");
    }
  }

  // ============================
  //  ACTUALIZAR CAMPO INDIVIDUAL
  // ============================
  Future<void> actualizarCampo(String campo, String valor) async {
    try {
      await perfilService.actualizarPerfil(userId, {campo: valor});
      await cargarPerfil();
    } catch (e) {
      print("❌ Error al actualizar $campo: $e");
    }
  }

  // ============================
  //   ACTUALIZAR IMAGEN
  // ============================
  Future<void> actualizarImagen(File imagen) async {
    try {
      final result = await perfilService.actualizarImagen(userId, imagen.path);

      imagenPerfil.value = result["imagen_url"];
    } catch (e) {
      print("❌ Error al actualizar imagen: $e");
    }
  }

  Future<void> editPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      await actualizarImagen(File(picked.path));
    }
  }

  // ============================
  //   EDITAR CAMPOS DE TEXTO
  // ============================
  Future<void> editNombre(BuildContext context) async {
    _editarTexto(context, "Editar Nombre", nombre.value, (nuevo) {
      actualizarCampo("nombres", nuevo);
    });
  }

  Future<void> editApellido(BuildContext context) async {
    _editarTexto(context, "Editar Apellido", apellido.value, (nuevo) {
      actualizarCampo("apellidos", nuevo);
    });
  }

  Future<void> editEmail(BuildContext context) async {
    _editarTexto(context, "Editar Email", email.value, (nuevo) {
      actualizarCampo("correo", nuevo);
    });
  }

  // ============================
  //       EDITAR GÉNERO
  // ============================
  void selectGenero(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Seleccionar género"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("Masculino"),
              onTap: () {
                genero.value = "Masculino";
                actualizarCampo("genero", "Masculino");
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Femenino"),
              onTap: () {
                genero.value = "Femenino";
                actualizarCampo("genero", "Femenino");
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============================
  //    EDITAR FECHA DE NACIMIENTO
  // ============================
  Future<void> selectFechaNacimiento(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 3650)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final fecha = "${picked.year}-${picked.month}-${picked.day}";
      fechaNacimiento.value = fecha;
      actualizarCampo("fecha_nacimiento", fecha);
    }
  }

  // ============================
  //   CERRAR SESIÓN
  // ============================
  void cerrarSesion(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // 🔥 Limpia todos los datos almacenados
    await prefs.clear();

    // 🔥 Elimina el controlador de memoria
    Get.delete<PerfilController>();
    // Forzar eliminación de HomeController para evitar datos estancados
    if (Get.isRegistered<HomeController>()) {
      Get.delete<HomeController>(force: true);
    }
    if (Get.isRegistered<ChatController>()) {
      Get.find<ChatController>().clearMessages();
      Get.delete<ChatController>();
    }

    // 🔄 Redirige al login
    Navigator.pushNamedAndRemoveUntil(context, "/login", (_) => false);
  }

  // ============================
  //  DIÁLOGO EDITAR TEXTO GENÉRICO
  // ============================
  void _editarTexto(
    BuildContext context,
    String titulo,
    String valorInicial,
    Function(String) onSave,
  ) {
    TextEditingController controller = TextEditingController(
      text: valorInicial,
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(titulo),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: "Nuevo valor"),
        ),
        actions: [
          TextButton(
            child: Text("Cancelar"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("Guardar"),
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // ============================
  //     VOLVER ATRÁS
  // ============================
  void goBack(BuildContext context) => Navigator.pop(context);
}
