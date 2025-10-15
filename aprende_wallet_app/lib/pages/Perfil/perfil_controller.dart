import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Perfil/perfil_modals/editar_nombre_perfil.dart';
import '../Perfil/perfil_modals/editar_apellido_perfil.dart';
import '../Perfil/perfil_modals/editar_correo_perfil.dart';
import '../Perfil/perfil_modals/seleccionar_fecha_nacimiento.dart';
import '../Perfil/perfil_modals/seleccionar_genero.dart';

class PerfilController extends GetxController {
  // Datos del usuario (hardcodeados por ahora)
  RxString nombre = ''.obs;
  RxString apellido = ''.obs;
  RxString email = 'divadibu32@gmail.com'.obs;
  RxString fechaNacimiento = 'No especificado'.obs;
  RxString genero = 'No especificado'.obs;
  RxString photoUrl = ''.obs; // URL de la foto de perfil

  // Método para volver atrás
  void goBack(BuildContext context) {
    // Navega al home y limpia la pila
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  // Método para editar foto
  void editPhoto() {
    // Más adelante abrirá selector de imagen
    print('Editar foto de perfil');
  }

  // Método para editar nombre
  void editNombre(BuildContext context) {
    EditarNombrePerfilModal.show(
      context: context,
      initialValue: nombre.value,
      onChanged: (value) {
        nombre.value = value;
      },
      onAccept: (value) {
        nombre.value = value;
      },
    );
  }

  // Método para editar apellido
  void editApellido(BuildContext context) {
    EditarApellidoPerfilModal.show(
      context: context,
      initialValue: apellido.value,
      onChanged: (value) {
        apellido.value = value;
      },
      onAccept: (value) {
        apellido.value = value;
      },
    );
  }

  // Método para editar email (puede requerir verificación)
  void editEmail(BuildContext context) {
    EditarCorreoPerfilModal.show(
      context: context,
      initialValue: email.value,
      onChanged: (value) {
        email.value = value;
      },
      onAccept: (value) {
        email.value = value;
      },
    );
  }

  // Método para seleccionar fecha de nacimiento
  void selectFechaNacimiento(BuildContext context) {
    SeleccionarFechaNacimientoModal.show(
      context: context,
      initialDate: fechaNacimiento.value,
      onSelect: (value) {
        fechaNacimiento.value = value;
      },
    );
  }

  // Método para seleccionar género
  void selectGenero(BuildContext context) {
    SeleccionarGeneroModal.show(
      context: context,
      selectedGenero: genero.value,
      onSelect: (nuevoGenero) {
        genero.value = nuevoGenero;
      },
    );
  }

  // Método para cerrar sesión
  void cerrarSesion(BuildContext context) {
    Get.defaultDialog(
      title: 'Cerrar sesión',
      middleText: '¿Estás seguro que deseas cerrar sesión?',
      textConfirm: 'Sí, cerrar sesión',
      textCancel: 'Cancelar',
      confirmTextColor: Colors.white,
      onConfirm: () {
        // Más adelante limpiará la sesión y navegará al login
        Get.back(); // Cierra el diálogo
        print('Cerrando sesión...');
        // Navigator.pushReplacementNamed(context, '/login');
      },
    );
  }
}