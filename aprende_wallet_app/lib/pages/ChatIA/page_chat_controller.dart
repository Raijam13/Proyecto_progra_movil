import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aprende_wallet_app/Services/chat_service.dart';

class ChatController extends GetxController {
  final ChatService chatService = ChatService();
  var messages = <Map<String, String>>[].obs;

  Future<void> sendMessage(String userText) async {
    if (userText.trim().isEmpty) return;

    final horaActual = DateFormat('HH:mm').format(DateTime.now());

    // Agregar mensaje del usuario
    messages.add({'text': userText, 'sender': 'user', 'time': horaActual});

    await _sendAndReceive(userText);
  }

  Future<void> _sendAndReceive(String userText) async {
    final horaActual = DateFormat('HH:mm').format(DateTime.now());

    // ✅ Leer el ID del usuario desde SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final userId =
        prefs.getInt("user_id") ?? 1; // por defecto 1 si no está guardado

    try {
      final response = await chatService.getResponse(userText, userId);

      messages.add({'text': response, 'sender': 'bot', 'time': horaActual});
    } catch (e) {
      messages.add({
        'text': "Error al obtener respuesta del servidor.",
        'sender': 'bot',
        'time': horaActual,
      });
    }
  }

  void clearMessages() {
    messages.clear();
  }
}
