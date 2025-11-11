class SignUpModel {
  final String nombres;
  final String apellidos;
  final String correo;
  final String contrasena;

  SignUpModel({
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.contrasena,
  });

  Map<String, dynamic> toJson() {
    return {
      "nombres": nombres,
      "apellidos": apellidos,
      "correo": correo,
      "contrasena": contrasena,
    };
  }
}
