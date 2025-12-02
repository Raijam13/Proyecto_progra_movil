import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:aprende_wallet_app/Services/pagos_planificados_service.dart';
import 'package:aprende_wallet_app/pages/Planificacion/pagos_planificados/pagos_planificados_controller.dart';
import 'package:aprende_wallet_app/models/pago_planificado_model.dart';

class AgregarPagoPlanificadoController extends GetxController {
  final PagosPlanificadosService _pagosService = PagosPlanificadosService();

  // Form fields
  final monto = 0.0.obs;
  final nombre = ''.obs;
  final tipo = 'gasto'.obs; // 'gasto' or 'ingreso'
  final periodo = 'Mensual'.obs;
  final categoria = ''.obs;
  final cuenta = ''.obs;

  // Edit Mode
  final isEditing = false.obs;
  int? _editingId;

  // IDs for backend
  int? _idCuenta;

  // Catalogs
  final RxList<dynamic> categoriasList = [].obs;
  final RxList<dynamic> frecuenciasList = [].obs;
  final RxList<dynamic> cuentasList = [].obs;
  final RxList<dynamic> tiposPagoList = [].obs;

  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCatalogos();
    _checkArguments();
  }

  void _checkArguments() {
    final args = Get.arguments;
    if (args != null && args is PagoPlanificado) {
      isEditing.value = true;
      _editingId = args.id;
      nombre.value = args.nombre;
      monto.value = args.monto;
      tipo.value = args.tipo;
      periodo.value = args.periodo;
      categoria.value = args.categoria;
      // Note: We don't have account name in the model, so it might stay empty or we need to fetch it
      // For now, we leave it empty or set a placeholder if we had the ID
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
      var response = await _pagosService.getCatalogos(userId);

      if (response.success && response.data != null) {
        categoriasList.assignAll(response.data!['categorias'] ?? []);
        frecuenciasList.assignAll(response.data!['frecuencias'] ?? []);
        cuentasList.assignAll(response.data!['cuentas'] ?? []);
        tiposPagoList.assignAll(response.data!['tipos_pago'] ?? []);

        // Set defaults if available and not editing
        if (!isEditing.value && frecuenciasList.isNotEmpty) {
          periodo.value = frecuenciasList.first['nombre'];
        }
      } else {
        Get.snackbar('Error', 'No se pudieron cargar los catálogos');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error al cargar catálogos: $e');
    } finally {
      isLoading(false);
    }
  }

  void setTipo(String nuevoTipo) {
    tipo.value = nuevoTipo;
  }

  void setMonto(double nuevoMonto) {
    monto.value = nuevoMonto;
  }

  void editarNombre(BuildContext context) {
    TextEditingController txtCtrl = TextEditingController(text: nombre.value);
    Get.defaultDialog(
      title: "Nombre del pago",
      content: TextField(
        controller: txtCtrl,
        decoration: const InputDecoration(hintText: "Ej. Netflix, Alquiler"),
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
    _showSelectionModal(context, "Seleccionar Frecuencia", frecuenciasList, (
      item,
    ) {
      periodo.value = item['nombre'];
    });
  }

  void seleccionarCategoria(BuildContext context) {
    _showSelectionModal(context, "Seleccionar Categoría", categoriasList, (
      item,
    ) {
      categoria.value = item['nombre'];
    });
  }

  void seleccionarCuenta(BuildContext context) {
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
                  ? const Center(
                      child: Text(
                        "No hay opciones disponibles",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (ctx, i) {
                        final item = items[i];
                        return ListTile(
                          leading: const Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                          title: Text(
                            item['nombre']?.toString() ?? 'Sin nombre',
                          ),
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
      isScrollControlled: true,
    );
  }

  void guardarPagoPlanificado() async {
    if (nombre.value.isEmpty ||
        monto.value <= 0 ||
        categoria.value.isEmpty ||
        cuenta.value.isEmpty) {
      Get.snackbar('Error', 'Por favor completa todos los campos requeridos');
      return;
    }

    try {
      isLoading.value = true;

      final data = {
        "nombre": nombre.value,
        "monto": monto.value,
        "tipo": tipo.value,
        "periodo": periodo.value,
        "categoria": categoria.value,
        "id_cuenta":
            _idCuenta ?? 1, // Fallback if not selected but text is present
        "tipo_pago": "Efectivo",
        "fecha_inicio": DateTime.now().toIso8601String(),
        "intervalo": 1,
        "idUsuario": await _getUserId(),
      };

      dynamic response;
      if (isEditing.value && _editingId != null) {
        response = await _pagosService.updatePagoPlanificado(_editingId!, data);
      } else {
        response = await _pagosService.createPagoPlanificado(data);
      }

      if (response.success) {
        Get.back();
        Get.snackbar(
          'Éxito',
          isEditing.value ? 'Pago actualizado' : 'Pago guardado',
        );
        if (Get.isRegistered<PagosPlanificadosController>()) {
          Get.find<PagosPlanificadosController>().fetchPagosPlanificados();
        }
      } else {
        Get.snackbar('Error', response.message ?? 'Error al guardar');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error inesperado: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void eliminarPagoPlanificado() async {
    if (_editingId == null) return;

    try {
      isLoading.value = true;
      final userId = await _getUserId();
      final response = await _pagosService.deletePagoPlanificado(
        _editingId!,
        userId,
      );

      if (response.success) {
        Get.back(); // Close edit page
        Get.snackbar('Éxito', 'Pago eliminado correctamente');
        if (Get.isRegistered<PagosPlanificadosController>()) {
          Get.find<PagosPlanificadosController>().fetchPagosPlanificados();
        }
      } else {
        Get.snackbar('Error', response.message ?? 'No se pudo eliminar');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error al eliminar: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
