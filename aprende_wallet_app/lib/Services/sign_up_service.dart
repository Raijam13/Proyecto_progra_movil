import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sign_up_model.dart';

class SignUpService {
  // DEBE SER ESTA URL PARA ANDROID EMULATOR:
  final String baseUrl = "http://10.0.2.2:4567";

  Future<Map<String, dynamic>> registrarUsuario(SignUpModel model) async {
    final url = Uri.parse('$baseUrl/registro');
    
    print('🔍 URL de REGISTRO: $url');
    print('📦 Datos registro: ${model.toJson()}');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(model.toJson()),
      );

      print('📡 Status code registro: ${response.statusCode}');
      print('📄 Respuesta registro: ${response.body}');

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {
          "success": true,
          "message": responseBody['message'] ?? "Registro exitoso",
        };
      } else {
        return {
          "success": false,
          "message": responseBody['message'] ?? "Error en el registro",
        };
      }
    } catch (e) {
      print('❌ Error REGISTRO: $e');
      return {
        "success": false,
        "message": "No se puede conectar al servidor en $url",
      };
    }
  }
}