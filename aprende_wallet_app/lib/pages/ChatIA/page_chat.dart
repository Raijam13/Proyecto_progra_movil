import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'page_chat_controller.dart';
import 'package:aprende_wallet_app/components/navBar.dart';
import 'package:aprende_wallet_app/pages/Home/home_controller.dart';
import 'package:aprende_wallet_app/pages/Services/chat_service.dart'; 

class ChatPage extends StatelessWidget {
  // registrar servicio antes que el controller (importante: ChatController usa Get.find<ChatService>())
  final ChatService chatService = Get.put(ChatService());
  final ChatController control = Get.put(ChatController());
  final HomeController homeControl = Get.find<HomeController>();

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      // App bar -> IA Wallet
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScheme.primaryContainer.withOpacity(0.1),
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: colorScheme.primary,
              child: Icon(Icons.smart_toy,
                  color: colorScheme.onPrimary, size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              'IA Wallet',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          // Lista de mensajes
          Expanded(
            child: Obx(() => ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  reverse: true, // muestra los mensajes nuevos al final
                  itemCount: control.messages.length,
                  itemBuilder: (context, index) {
                    // construimos la lista invertida para mostrar los más recientes abajo
                    final msg = control.messages.reversed.toList()[index];
                    final isUser = msg['sender'] == 'user';

                    return Align(
                      alignment: isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        constraints: const BoxConstraints(maxWidth: 280),
                        decoration: BoxDecoration(
                          color: isUser
                              ? colorScheme.primary
                              : colorScheme.surfaceVariant.withOpacity(0.7),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(isUser ? 16 : 4),
                            bottomRight: Radius.circular(isUser ? 4 : 16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: isUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              msg['text'] ?? '',
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.4,
                                color: isUser
                                    ? colorScheme.onPrimary
                                    : colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // ⏰ Hora del mensaje
                            Text(
                              msg['time'] ?? '',
                              style: TextStyle(
                                fontSize: 11,
                                color: isUser
                                    ? colorScheme.onPrimary.withOpacity(0.8)
                                    : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          ),

          // Botones rápidos al final
          _buildQuickOptions(context),
        ],
      ),

      // Mantiene la barra inferior
      bottomNavigationBar: Obx(
        () => CustomBottomNavBar(
          currentIndex: homeControl.currentNavIndex.value,
          onTap: (index) => homeControl.changeNavIndex(index, context),
        ),
      ),
    );
  }

  // Botones predefinidos
  Widget _buildQuickOptions(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final options = [
      '¿Cómo voy con mis gastos este mes?',
      '¿En qué categoría gasté más?',
      '¿Estoy gastando más que el mes pasado?',
      '¿Cómo puedo mejorar mis finanzas personales?',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: options.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // hace los botones del mismo tamaño
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 3.5,
        ),
        itemBuilder: (context, index) {
          final text = options[index];
          return ElevatedButton(
            onPressed: () => control.sendMessage(text),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }
}
