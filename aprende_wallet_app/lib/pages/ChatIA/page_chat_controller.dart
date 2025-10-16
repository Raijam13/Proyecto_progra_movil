import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {
  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  List<Map<String, dynamic>> respuestas = [];

  @override
  void onInit() {
    super.onInit();
    _loadResponses();
  }

  /// Carga las respuestas desde el archivo JSON
  Future<void> _loadResponses() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/chat_responses.json');
    final Map<String, dynamic> data = json.decode(jsonString);
    respuestas = List<Map<String, dynamic>>.from(data['respuestas']);
  }

  /// Envía mensaje del usuario con hora
  void sendMessage(String text) {
    final horaActual = DateFormat('HH:mm').format(DateTime.now());

    messages.add({
      'text': text,
      'sender': 'user',
      'time': horaActual,
    });

    _simulateResponse(text);
  }

  /// Simula respuesta usando coincidencia con el JSON
  void _simulateResponse(String userText) async {
    await Future.delayed(const Duration(seconds: 1));

    final horaActual = DateFormat('HH:mm').format(DateTime.now());
    String response = _buscarRespuesta(userText.toLowerCase());

    messages.add({
      'text': response,
      'sender': 'bot',
      'time': horaActual,
    });
  }

  /// Busca coincidencias en las palabras clave del JSON
  String _buscarRespuesta(String textoUsuario) {
    for (var item in respuestas) {
      for (var palabra in item['keywords']) {
        if (textoUsuario.contains(palabra.toLowerCase())) {
          return item['respuesta'];
        }
      }
    }
    return 'No tengo información específica sobre eso, pero puedo ayudarte a analizar tus finanzas.';
  }
}
