import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:aprende_wallet_app/services/pagos_planificados_service.dart';
import 'package:aprende_wallet_app/pages/Planificacion/pagos_planificados/pagos_planificados_controller.dart';

class AgregarPagoPlanificadoController extends GetxController {
  final PagosPlanificadosService _pagosService = PagosPlanificadosService();

  // Form fields
  final monto = 0.0.obs;
  final nombre = ''.obs;
  final tipo = 'gasto'.obs; // 'gasto' or 'ingreso'
  final periodo = 'Mensual'.obs;
  final categoria = ''.obs;
  final cuenta = ''.obs;
  
  // IDs for backend
  int? _idCuenta;
  int? _idCategoria; // We might need to store ID if backend requires it, but current UI only shows name. 
                     // Assuming backend resolves by name or we need to store ID.
                     // The service/backend expects IDs usually.
                     // Let's store the full objects or IDs.
  
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
  }

  void fetchCatalogos() async {
    try {
      isLoading(true);
      var response = await _pagosService.getCatalogos();
      if (response.success && response.data != null) {
        categoriasList.assignAll(response.data!['categorias'] ?? []);
        frecuenciasList.assignAll(response.data!['frecuencias'] ?? []);
        cuentasList.assignAll(response.data!['cuentas'] ?? []);
        tiposPagoList.assignAll(response.data!['tipos_pago'] ?? []);
        
        // Set defaults if available
        if (frecuenciasList.isNotEmpty) periodo.value = frecuenciasList.first['nombre'];
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
    _showSelectionModal(context, "Seleccionar Frecuencia", frecuenciasList, (item) {
      periodo.value = item['nombre'];
    });
  }

  void seleccionarCategoria(BuildContext context) {
    _showSelectionModal(context, "Seleccionar Categoría", categoriasList, (item) {
      categoria.value = item['nombre'];
      _idCategoria = item['id'];
    });
  }

  void seleccionarCuenta(BuildContext context) {
    _showSelectionModal(context, "Seleccionar Cuenta", cuentasList, (item) {
      cuenta.value = item['nombre'];
      _idCuenta = item['id'];
    });
  }

  void _showSelectionModal(BuildContext context, String title, List<dynamic> items, Function(dynamic) onSelect) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (ctx, i) {
                  final item = items[i];
                  return ListTile(
                    title: Text(item['nombre']),
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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    );
  }

  void guardarPagoPlanificado() async {
    if (nombre.value.isEmpty || monto.value <= 0 || categoria.value.isEmpty || cuenta.value.isEmpty) {
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
        "id_cuenta": _idCuenta,
        "tipo_pago": "Efectivo", // Default or add selector
        // Optional fields
        "fecha_inicio": DateTime.now().toIso8601String(), 
        "intervalo": 1
      };

      var response = await _pagosService.createPagoPlanificado(data);

      if (response.success) {
        Get.back();
        Get.snackbar('Éxito', 'Pago guardado correctamente');
        // Refresh list
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
}