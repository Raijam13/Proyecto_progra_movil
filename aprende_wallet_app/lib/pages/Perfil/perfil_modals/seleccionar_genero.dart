
import 'package:flutter/material.dart';

class SeleccionarGeneroModal extends StatelessWidget {
  final String selectedGenero;
  final Function(String) onSelect;

  static const List<Map<String, dynamic>> generos = [
    {
      'name': 'Masculino',
      'icon': Icons.male,
    },
    {
      'name': 'Femenino',
      'icon': Icons.female,
    },
    {
      'name': 'No especificado',
      'icon': Icons.help_outline,
    },
  ];

  const SeleccionarGeneroModal({
    super.key,
    required this.selectedGenero,
    required this.onSelect,
  });

  static void show({
    required BuildContext context,
    required String selectedGenero,
    required Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SeleccionarGeneroModal(
          selectedGenero: selectedGenero,
          onSelect: onSelect,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
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
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: _buildGeneroList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Configurar perfil',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'Género',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneroList(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: generos.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        indent: 60,
        endIndent: 16,
        color: Colors.grey[200],
      ),
      itemBuilder: (context, index) {
        final genero = generos[index];
        final isSelected = genero['name'] == selectedGenero;

        return InkWell(
          onTap: () {
            onSelect(genero['name']);
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Icono
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    genero['icon'],
                    size: 20,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 12),
                // Nombre del género
                Expanded(
                  child: Text(
                    genero['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Check si está seleccionado
                if (isSelected)
                  Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
