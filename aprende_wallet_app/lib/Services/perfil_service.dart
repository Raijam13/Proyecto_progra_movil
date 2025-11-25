import 'dart:convert';
import 'package:http/http.dart' as http;

class PerfilService {
  final String baseUrl = "http://10.0.2.2:4567";

  // Obtener perfil
  Future<Map<String, dynamic>> obtenerPerfil(String id) async {
    final url = Uri.parse("$baseUrl/perfil/$id");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "Error al obtener perfil: ${response.body}";
      }
    } catch (e) {
      throw "Error de conexión: $e";
    }
  }

  // Actualizar perfil parcial
  Future<Map<String, dynamic>> actualizarPerfil(String id, Map<String, dynamic> data) async {
    final url = Uri.parse("$baseUrl/perfil/$id");

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "Error al actualizar perfil: ${response.body}";
      }
    } catch (e) {
      throw "Error de conexión: $e";
    }
  }

  // Subir imagen de perfil
  Future<Map<String, dynamic>> actualizarImagen(String id, String filePath) async {
    final url = Uri.parse("$baseUrl/perfil/$id/imagen");

    var request = http.MultipartRequest("PUT", url);
    request.files.add(await http.MultipartFile.fromPath("imagen", filePath));

    try {
      final response = await request.send();
      final body = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return jsonDecode(body);
      } else {
        throw "Error al subir imagen: $body";
      }
    } catch (e) {
      throw "Error de conexión: $e";
    }
  }
}
