// lib/models/login_model.dart
class SignInModel {
  final String correo;
  final String contrasena;

  SignInModel({
    required this.correo,
    required this.contrasena,
  });

  Map<String, dynamic> toJson() {
    return {
      'correo': correo,
      'contraseña': contrasena, // debe coincidir con la clave esperada en el backend
    };
  }
}
