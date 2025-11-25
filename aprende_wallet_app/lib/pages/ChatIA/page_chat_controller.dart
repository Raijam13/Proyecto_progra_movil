import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:aprende_wallet_app/services/chat_service.dart';

class ChatController extends GetxController {
  final ChatService chatService = ChatService();

  // Lista reactiva de mensajes
  // Cada mensaje: { text: "...", sender: "user" | "bot", time: "HH:mm" }
  var messages = <Map<String, String>>[].obs;

  // Enviar mensaje del usuario y recibir respuesta del bot
  Future<void> sendMessage(String userText) async {
    if (userText.trim().isEmpty) return;

    final horaActual = DateFormat('HH:mm').format(DateTime.now());

    // 1. Agregar mensaje del usuario
    messages.add({
      'text': userText,
      'sender': 'user',
      'time': horaActual,
    });

    // 2. Llamar al método que envía al backend y recibe respuesta
    await _sendAndReceive(userText);
  }

  // Función interna que consulta al backend
  Future<void> _sendAndReceive(String userText) async {
    final horaActual = DateFormat('HH:mm').format(DateTime.now());

    // Id de usuario (ajústalo si lo sacas de Session/GetStorage)
    const int userId = 1;

    try {
      final response = await chatService.getResponse(userText, userId);

      // 3. Agregar mensaje del bot
      messages.add({
        'text': response,
        'sender': 'bot',
        'time': horaActual,
      });
    } catch (e) {
      messages.add({
        'text': "Error al obtener respuesta del servidor.",
        'sender': 'bot',
        'time': horaActual,
      });
    }
  }
}
