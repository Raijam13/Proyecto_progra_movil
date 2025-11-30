import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:get/get.dart';

import 'package:aprende_wallet_app/config/api_config.dart';

class ChatService {
  final String apiUrl = "${ApiConfig.baseUrl}/chat"; // backend Ruby

  /// Envía el mensaje al backend y retorna la respuesta del bot
  Future<String> getResponse(String userText, int userId) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"mensaje": userText, "idUsuario": userId}),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        // Backend might return { "respuesta": "..." } or { "success": true, "data": { ... } }
        if (body.containsKey("respuesta")) {
          return body["respuesta"];
        } else if (body.containsKey("data") &&
            body["data"] is Map &&
            body["data"].containsKey("respuesta")) {
          return body["data"]["respuesta"];
        }
        return "Respuesta no entendible del servidor";
      } else {
        return "Error: ${response.statusCode}";
      }
    } catch (e) {
      return "Error al conectar con el servidor";
    }
  }
}
