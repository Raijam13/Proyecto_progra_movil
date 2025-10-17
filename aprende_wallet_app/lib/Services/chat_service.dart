import 'dart:convert';
import 'package:flutter/services.dart';

class ChatService {
  List<Map<String, dynamic>> respuestas = [];

  /// Carga las respuestas desde assets (llamar antes de usar getResponse)
  Future<void> loadResponses() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/chat_responses.json');
      final Map<String, dynamic> data = json.decode(jsonString);
      respuestas = List<Map<String, dynamic>>.from(data['respuestas'] ?? []);
    } catch (e) {
      // Manejo simple de errores (log) y dejar respuestas vacío
      respuestas = [];
      // print('Error cargando respuestas: $e');
    }
  }

  /// Busca la mejor respuesta en el JSON (sincrónico)
  String buscarRespuesta(String textoUsuario) {
    final lower = textoUsuario.toLowerCase();
    for (var item in respuestas) {
      final keywords = List<String>.from(item['keywords'] ?? []);
      for (var palabra in keywords) {
        if (lower.contains(palabra.toLowerCase())) {
          return item['respuesta'] ?? _respuestaPorDefecto();
        }
      }
    }
    return _respuestaPorDefecto();
  }

  String _respuestaPorDefecto() =>
      'No tengo información específica sobre eso, pero puedo ayudarte a analizar tus finanzas.';

  /// Interfaz para obtener la respuesta (simula latencia)
  Future<String> getResponse(String userText) async {
    // Simular retardo (como si llamaras a una API)
    await Future.delayed(const Duration(milliseconds: 900));
    return buscarRespuesta(userText);
  }
}
