import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sign_in_model.dart';

class SignInService {
  final String baseUrl = "http://localhost:4576"; // Cambia según tu IP o entorno

  Future<Map<String, dynamic>> login(SignInModel model) async {
    final url = Uri.parse('http://10.0.2.2:4567/login');


    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        return {
          "success": true,
          "message": jsonDecode(response.body)['message'],
        };
      } else {
        return {
          "success": false,
          "message": jsonDecode(response.body)['message'] ?? "Error desconocido",
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": "Error de conexión: $e",
      };
    }
  }
}
