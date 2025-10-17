import 'package:get/get.dart';
import 'package:aprende_wallet_app/models/presupuesto_model.dart';
import 'package:aprende_wallet_app/services/presupuestos_service.dart';

class PresupuestosController extends GetxController {
  final PresupuestosService _presupuestosService = PresupuestosService();

  // Estados observables para la UI
  RxBool isLoading = true.obs;
  RxList<Presupuesto> presupuestosList = <Presupuesto>[].obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPresupuestos();
  }

  /// Obtiene los presupuestos desde el servicio y actualiza el estado.
  void fetchPresupuestos() async {
    try {
      isLoading(true); // También se puede usar .value = true
      errorMessage.value = ''; // Limpiar errores previos
      var response = await _presupuestosService.getPresupuestos();

      if (response.success && response.data != null) {
        presupuestosList.assignAll(response.data!);
      } else {
        // Guardamos el mensaje de error para que la UI pueda reaccionar
        errorMessage.value =
            response.message ?? "Ocurrió un error al cargar los datos.";
      }
    } finally {
      isLoading(false);
    }
  }
}
