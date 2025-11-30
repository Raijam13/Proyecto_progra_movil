import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sign_in_model.dart';

import 'package:aprende_wallet_app/config/api_config.dart';

class SignInService {
  final String baseUrl = ApiConfig.baseUrl;

  Future<Map<String, dynamic>> login(SignInModel model) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/login');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(model.toJson()),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          "status": data["status"],
          "message": data["message"],
          "usuario": data["usuario"], // ← AQUÍ VIENE EL ID
        };
      } else {
        return {
          "status": data["status"],
          "message": data["message"],
          "usuario": null, // ← Importante
        };
      }
    } catch (e) {
      return {
        "status": "error",
        "message": "Error de conexión: $e",
        "usuario": null,
      };
    }
  }
}
