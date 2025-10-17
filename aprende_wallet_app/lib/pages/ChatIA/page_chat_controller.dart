import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:aprende_wallet_app/Services/chat_service.dart';

class ChatController extends GetxController {
  final ChatService chatService = Get.find<ChatService>();

  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initService();
  }

  Future<void> _initService() async {
    // Asegurarse de cargar las respuestas antes de usarlas
    await chatService.loadResponses();
  }

  /// Envía mensaje del usuario (añade con hora) y solicita respuesta del servicio
  void sendMessage(String text) {
    final horaActual = DateFormat('HH:mm').format(DateTime.now());

    messages.add({
      'text': text,
      'sender': 'user',
      'time': horaActual,
    });

    _sendAndReceive(text);
  }

  Future<void> _sendAndReceive(String userText) async {
    final response = await chatService.getResponse(userText);
    final horaActual = DateFormat('HH:mm').format(DateTime.now());

    messages.add({
      'text': response,
      'sender': 'bot',
      'time': horaActual,
    });
  }
}
