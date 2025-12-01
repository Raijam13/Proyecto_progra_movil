import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aprende_wallet_app/Services/presupuestos_service.dart';
import 'package:aprende_wallet_app/models/presupuesto_model.dart';

class AgregarPresupuestoController extends GetxController {
  final PresupuestosService _service = PresupuestosService();

  // Form fields
  final monto = 0.0.obs;
  final nombre = ''.obs;
  final periodo = 'Mensual'.obs;
  final categoria = ''.obs;
  final cuenta = ''.obs; // Optional, maybe budgets are per account or global

  // IDs
  int? _idCategoria;
  int? _idCuenta;

  // Edit Mode
  final isEditing = false.obs;
  int? _editingId;

  // Catalogs
  final RxList<dynamic> categoriasList = [].obs;
  final RxList<dynamic> frecuenciasList = [].obs;
  final RxList<dynamic> cuentasList = [].obs;

  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCatalogos();
    _checkArguments();
  }

  void _checkArguments() {
    final args = Get.arguments;
    if (args != null && args is Presupuesto) {
      isEditing.value = true;
      _editingId = args.id;
      nombre.value = args.nombre;
      monto.value = args.montoTotal;
      periodo.value = args.periodo;
      categoria.value = args.categoria;
      cuenta.value = args.cuenta;
      _idCategoria = args.idCategoria;
      _idCuenta = args.idCuenta;
    }
  }

  Future<int> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id') ?? -1;
  }

  Future<void> fetchCatalogos() async {
    try {
      isLoading(true);
      final userId = await _getUserId();
      var response = await _service.getCatalogos(userId);

      if (response.success && response.data != null) {
        categoriasList.assignAll(response.data!['categorias'] ?? []);
        frecuenciasList.assignAll(response.data!['frecuencias'] ?? []);
        cuentasList.assignAll(response.data!['cuentas'] ?? []);

        if (!isEditing.value && frecuenciasList.isNotEmpty) {
          periodo.value = frecuenciasList.first['nombre'];
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Error al cargar catálogos: $e');
    } finally {
      isLoading(false);
    }
  }

  void setMonto(double value) => monto.value = value;

  void editarNombre(BuildContext context) {
    TextEditingController txtCtrl = TextEditingController(text: nombre.value);
    Get.defaultDialog(
      title: "Nombre del Presupuesto",
      content: TextField(
        controller: txtCtrl,
        decoration: const InputDecoration(hintText: "Ej. Comida, Transporte"),
      ),
      textConfirm: "Aceptar",
      textCancel: "Cancelar",
      onConfirm: () {
        nombre.value = txtCtrl.text;
        Get.back();
      },
    );
  }

  void seleccionarPeriodo(BuildContext context) {
    _showSelectionModal(context, "Seleccionar Periodo", frecuenciasList, (
      item,
    ) {
      periodo.value = item['nombre'];
    });
  }

  void seleccionarCategorias(BuildContext context) {
    _showSelectionModal(context, "Seleccionar Categoría", categoriasList, (
      item,
    ) {
      categoria.value = item['nombre'];
      _idCategoria = item['id'];
    });
  }

  void seleccionarCuentas(BuildContext context) {
    _showSelectionModal(context, "Seleccionar Cuenta", cuentasList, (item) {
      cuenta.value = item['nombre'];
      _idCuenta = item['id'];
    });
  }

  void _showSelectionModal(
    BuildContext context,
    String title,
    List<dynamic> items,
    Function(dynamic) onSelect,
  ) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.5,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: items.isEmpty
                  ? const Center(child: Text("No hay opciones"))
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (ctx, i) {
                        final item = items[i];
                        return ListTile(
                          title: Text(item['nombre'] ?? 'Sin nombre'),
                          onTap: () {
                            onSelect(item);
                            Get.back();
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  void guardarPresupuesto() async {
    if (nombre.value.isEmpty || monto.value <= 0) {
      Get.snackbar('Error', 'El nombre y el monto son requeridos.');
      return;
    }

    try {
      isLoading.value = true;
      final userId = await _getUserId();

      final data = {
        "nombre": nombre.value,
        "monto_total": monto.value,
        "periodo": periodo.value,
        "id_categoria": _idCategoria,
        "id_cuenta": _idCuenta,
        "user_id": userId,
        "fecha_inicio": DateTime.now().toIso8601String(),
      };

      dynamic response;
      if (isEditing.value && _editingId != null) {
        response = await _service.updatePresupuesto(_editingId!, data);
      } else {
        response = await _service.createPresupuesto(data);
      }

      if (response.success) {
        Get.back();
        Get.snackbar('Éxito', 'Presupuesto guardado correctamente');
        // Refresh list logic here if needed (e.g. find controller)
      } else {
        Get.snackbar('Error', response.message ?? 'Error al guardar');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error inesperado: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void eliminarPresupuesto() async {
    if (_editingId == null) return;
    try {
      isLoading.value = true;
      final userId = await _getUserId();
      final response = await _service.deletePresupuesto(_editingId!, userId);

      if (response.success) {
        Get.back();
        Get.snackbar('Éxito', 'Presupuesto eliminado');
      } else {
        Get.snackbar('Error', response.message ?? 'No se pudo eliminar');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
