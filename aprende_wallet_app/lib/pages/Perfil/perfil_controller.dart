import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/perfil_service.dart';

class PerfilController extends GetxController {
  final PerfilService perfilService = PerfilService();

  // Datos del usuario
  final nombre = ''.obs;
  final apellido = ''.obs;
  final email = ''.obs;
  final genero = ''.obs;
  final fechaNacimiento = ''.obs;
  final imagenPerfil = ''.obs;

  String userId = ""; // ← dinámico desde SharedPreferences

  @override
  void onInit() {
    super.onInit();
    cargarUserId(); // ← primero obtenemos el ID, luego se carga el perfil
  }

  // --------------------------------
  // 1) CARGAR ID DEL USUARIO
  // --------------------------------
  Future<void> cargarUserId() async {
    final prefs = await SharedPreferences.getInstance();

    final idGuardado = prefs.getInt("user_id");

    if (idGuardado == null) {
      print("⚠️ No se encontró user_id en SharedPreferences");
      return;
    }

    userId = idGuardado.toString();
    print("✅ ID cargado en PerfilController: $userId");

    cargarPerfil();
  }

  // ------------------------------
  //   OBTENER DATOS DEL PERFIL
  // ------------------------------
  Future<void> cargarPerfil() async {
    try {
      if (userId.isEmpty) return;

      final data = await perfilService.obtenerPerfil(userId);
      final usuario = data["usuario"];

      nombre.value = usuario["nombres"] ?? "";
      apellido.value = usuario["apellidos"] ?? "";
      email.value = usuario["correo"] ?? "";
      imagenPerfil.value = usuario["imagen_perfil"] ?? "";
    } catch (e) {
      print("Error cargando perfil: $e");
    }
  }

  // ------------------------------
  //    ACTUALIZAR CAMPO ÚNICO
  // ------------------------------
  Future<void> actualizarCampo(String campo, String valor) async {
    try {
      await perfilService.actualizarPerfil(userId, {campo: valor});
      await cargarPerfil();
    } catch (e) {
      print("Error actualizando campo: $e");
    }
  }

  // ------------------------------
  //    ACTUALIZAR IMAGEN DE PERFIL
  // ------------------------------
  Future<void> actualizarImagen(File imagen) async {
    try {
      final result =
          await perfilService.actualizarImagen(userId, imagen.path);

      imagenPerfil.value = result["imagen_url"];
    } catch (e) {
      print("Error al actualizar imagen: $e");
    }
  }

  // ------------------------------
  //      BOTÓN SELECCIONAR FOTO
  // ------------------------------
  Future<void> editPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      await actualizarImagen(File(picked.path));
    }
  }

  // ------------------------------
  //         EDITAR CAMPOS
  // ------------------------------
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

  // ------------------------------
  //      CAMPOS ESPECIALES
  // ------------------------------
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Femenino"),
              onTap: () {
                genero.value = "Femenino";
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------
  //   SELECCIONAR FECHA DE NACIMIENTO
  // ------------------------------
  Future<void> selectFechaNacimiento(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 3650)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      fechaNacimiento.value = "${picked.year}-${picked.month}-${picked.day}";
      actualizarCampo("fecha_nacimiento", fechaNacimiento.value);
    }
  }

  // ------------------------------
  //     CERRAR SESIÓN
  // ------------------------------
  void cerrarSesion(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/login");
  }

  // ------------------------------
  //    VOLVER ATRÁS
  // ------------------------------
  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  // ------------------------------
  //   DIÁLOGO EDITAR TEXTO
  // ------------------------------
  void _editarTexto(
      BuildContext context, String titulo, String valorInicial, Function(String) onSave) {
    TextEditingController controller =
        TextEditingController(text: valorInicial);

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
}
