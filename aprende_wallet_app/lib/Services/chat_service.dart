import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:get/get.dart';

class ChatService {
  final String apiUrl = "http://10.0.2.2:4567/chat"; // backend Ruby

  /// Envía el mensaje al backend y retorna la respuesta del bot
  Future<String> getResponse(String userText, int userId) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: { "Content-Type": "application/json" },
        body: jsonEncode({
          "mensaje": userText,
          "idUsuario": userId,
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body["respuesta"] ?? "Sin respuesta";
      } else {
        return "Error: ${response.body}";
      }
    } catch (e) {
      return "Error al conectar con el servidor";
    }
  }
}

