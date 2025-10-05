import 'package:flutter/material.dart';

class EditarApellidoPerfilModal extends StatelessWidget {
  final String initialValue;
  final Function(String) onChanged;
  final Function(String) onAccept;

  const EditarApellidoPerfilModal({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.onAccept,
  });

  static void show({
    required BuildContext context,
    required String initialValue,
    required Function(String) onChanged,
    required Function(String) onAccept,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return EditarApellidoPerfilModal(
          initialValue: initialValue,
          onChanged: onChanged,
          onAccept: onAccept,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController apellidoController = TextEditingController(text: initialValue);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            _buildHeader(context),
            const Divider(height: 1),
            _buildTextField(apellidoController),
            const Spacer(),
            _buildAcceptButton(context, apellidoController),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(
                  'Atrás',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'Apellido',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 70),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Apellido',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            autofocus: true,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Ingresa tu apellido',
              hintStyle: TextStyle(
                fontSize: 24,
                color: Colors.grey,
              ),
            ),
            onChanged: (value) {
              onChanged(value);
            },
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildAcceptButton(BuildContext context, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            onAccept(controller.text);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Text(
            'aceptar',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}