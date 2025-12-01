import 'package:get/get.dart';
import 'package:aprende_wallet_app/models/presupuesto_model.dart';
import 'package:aprende_wallet_app/Services/presupuestos_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<int> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id') ?? -1;
  }

  /// Obtiene los presupuestos desde el servicio y actualiza el estado.
  void fetchPresupuestos() async {
    try {
      isLoading(true);
      errorMessage.value = '';

      final userId = await _getUserId();
      print(">>> DEBUG: fetchPresupuestos userId: $userId");
      if (userId <= 0) {
        errorMessage.value = "Usuario no identificado (ID: $userId)";
        isLoading(false);
        return;
      }

      var response = await _presupuestosService.getPresupuestos(userId);

      if (response.success && response.data != null) {
        presupuestosList.assignAll(response.data!);
      } else {
        errorMessage.value =
            response.message ?? "Ocurrió un error al cargar los datos.";
      }
    } catch (e) {
      errorMessage.value = "Error inesperado: $e";
    } finally {
      isLoading(false);
    }
  }
}
