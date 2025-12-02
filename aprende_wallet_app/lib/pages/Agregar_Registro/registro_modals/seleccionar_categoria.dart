import 'package:flutter/material.dart';
import '../../../Services/categorias_service.dart';

class CategoriaItem {
  final int id;
  final String nombre;
  final IconData icono;
  final Color color;
  
  CategoriaItem({
    required this.id,
    required this.nombre,
    required this.icono,
    required this.color,
  });
}

class SeleccionarCategoriaModal {
  static Future<void> show({
    required BuildContext context,
    required Function(String nombre, int id) onSelect,
    String? initialCategoria,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return _SeleccionarCategoriaContent(onSelect: onSelect);
      },
    );
  }
}

class _SeleccionarCategoriaContent extends StatefulWidget {
  final Function(String nombre, int id) onSelect;

  const _SeleccionarCategoriaContent({required this.onSelect});

  @override
  State<_SeleccionarCategoriaContent> createState() => _SeleccionarCategoriaContentState();
}

class _SeleccionarCategoriaContentState extends State<_SeleccionarCategoriaContent> {
  List<CategoriaItem> categorias = [];
  List<CategoriaItem> filteredCategorias = [];
  bool isLoading = true;
  String? errorMessage;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarCategorias();
  }

  Future<void> _cargarCategorias() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await CategoriasService.listarCategorias();
      setState(() {
        categorias = data.map((cat) {
          return CategoriaItem(
            id: cat['id'] as int,
            nombre: cat['nombre'] as String,
            icono: _getIconForCategory(cat['nombre'] as String),
            color: _getColorForCategory(cat['nombre'] as String),
          );
        }).toList();
        filteredCategorias = List.from(categorias);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error al cargar categorías: $e';
        isLoading = false;
      });
    }
  }

  void _filtrarCategorias(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCategorias = List.from(categorias);
      } else {
        filteredCategorias = categorias
            .where((cat) => cat.nombre.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Text('Categorías', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: _filtrarCategorias,
              ),
            ),
            const SizedBox(height: 8),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(32.0),
                child: CircularProgressIndicator(),
              )
            else if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 8),
                    Text(errorMessage!, textAlign: TextAlign.center),
                  ],
                ),
              )
            else if (filteredCategorias.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Icon(Icons.search_off, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('No se encontraron categorías', textAlign: TextAlign.center),
                  ],
                ),
              )
            else ...[
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: const Text('TODAS LAS CATEGORÍAS', style: TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.bold)),
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredCategorias.length,
                  itemBuilder: (context, index) {
                    final cat = filteredCategorias[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: cat.color,
                        child: Icon(cat.icono, color: Colors.white),
                      ),
                      title: Text(cat.nombre, style: const TextStyle(fontSize: 16)),
                      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                      onTap: () {
                        widget.onSelect(cat.nombre, cat.id);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getIconForCategory(String nombre) {
    switch (nombre.toLowerCase()) {
      case 'alimentación':
        return Icons.restaurant;
      case 'transporte':
        return Icons.directions_car;
      case 'entretenimiento':
        return Icons.movie;
      case 'salud':
        return Icons.local_hospital;
      case 'educación':
        return Icons.school;
      case 'vivienda':
        return Icons.home;
      case 'ropa':
        return Icons.checkroom;
      case 'tecnología':
        return Icons.devices;
      case 'viajes':
        return Icons.flight;
      case 'otros':
        return Icons.more_horiz;
      default:
        return Icons.category;
    }
  }

  Color _getColorForCategory(String nombre) {
    switch (nombre.toLowerCase()) {
      case 'alimentación':
        return Colors.orange;
      case 'transporte':
        return Colors.blue;
      case 'entretenimiento':
        return Colors.purple;
      case 'salud':
        return Colors.red;
      case 'educación':
        return Colors.green;
      case 'vivienda':
        return Colors.brown;
      case 'ropa':
        return Colors.pink;
      case 'tecnología':
        return Colors.indigo;
      case 'viajes':
        return Colors.teal;
      case 'otros':
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }
}
