import 'package:get/get.dart';

class ChatController extends GetxController {
  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;

  void sendMessage(String text) {
    messages.add({'text': text, 'sender': 'user'});
    _simulateResponse(text);
  }

  void _simulateResponse(String userText) async {
    await Future.delayed(const Duration(seconds: 1));

    String response;
    if (userText.contains('gastos')) {
      response =
          'He revisado tus movimientos: llevas gastado el 78% de tu presupuesto mensual.';
    } else if (userText.contains('categoría')) {
      response =
          'La categoría con más consumo fue Comida a domicilio (35%), seguida de Transporte (20%).';
    } else if (userText.contains('pasado')) {
      response = 'Sí, este mes has gastado un 10% más que el mes anterior.';
    } else {
      response =
          'Podrías mejorar tus finanzas reduciendo gastos innecesarios y ahorrando un 15% de tus ingresos.';
    }

    messages.add({'text': response, 'sender': 'bot'});
  }
}
