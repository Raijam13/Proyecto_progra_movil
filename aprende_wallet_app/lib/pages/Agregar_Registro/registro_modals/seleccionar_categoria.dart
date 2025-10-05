import 'package:flutter/material.dart';

class CategoriaItem {
  final String nombre;
  final IconData icono;
  final Color color;
  CategoriaItem({required this.nombre, required this.icono, required this.color});
}

class SeleccionarCategoriaModal {
  static final List<CategoriaItem> categorias = [
    CategoriaItem(nombre: 'Comida y bebida', icono: Icons.restaurant, color: Colors.redAccent),
    CategoriaItem(nombre: 'Compras', icono: Icons.shopping_bag, color: Colors.blueAccent),
    CategoriaItem(nombre: 'Vivienda', icono: Icons.home, color: Colors.orangeAccent),
    CategoriaItem(nombre: 'Transporte', icono: Icons.directions_car, color: Colors.grey),
    CategoriaItem(nombre: 'Vehículo', icono: Icons.directions_bus, color: Colors.purpleAccent),
    CategoriaItem(nombre: 'Vida y entretenimiento', icono: Icons.emoji_emotions, color: Colors.green),
    CategoriaItem(nombre: 'Comunicación, PC', icono: Icons.computer, color: Colors.indigoAccent),
    CategoriaItem(nombre: 'Gastos financieros', icono: Icons.account_balance, color: Colors.teal),
    CategoriaItem(nombre: 'Inversiones', icono: Icons.trending_up, color: Colors.pinkAccent),
    CategoriaItem(nombre: 'Ingreso', icono: Icons.attach_money, color: Colors.lightGreen),
  ];

  static Future<void> show({
    required BuildContext context,
    required Function(String) onSelect,
    String? initialCategoria,
  }) async {
    TextEditingController searchController = TextEditingController();
    List<CategoriaItem> filtered = List.from(categorias);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                        onChanged: (value) {
                          setState(() {
                            filtered = categorias
                                .where((cat) => cat.nombre.toLowerCase().contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: const Text('TODAS LAS CATEGORÍAS', style: TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.bold)),
                    ),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final cat = filtered[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: cat.color,
                              child: Icon(cat.icono, color: Colors.white),
                            ),
                            title: Text(cat.nombre, style: const TextStyle(fontSize: 16)),
                            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                            onTap: () {
                              onSelect(cat.nombre);
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
