import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aprende_wallet_app/models/pago_planificado_model.dart';
import 'package:aprende_wallet_app/Services/pagos_planificados_service.dart';

class PagosPlanificadosController extends GetxController {
  final PagosPlanificadosService _pagosService = PagosPlanificadosService();

  RxBool isLoading = true.obs;
  RxList<PagoPlanificado> pagosList = <PagoPlanificado>[].obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPagosPlanificados();
  }

  Future<int> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id') ?? -1;
  }

  void fetchPagosPlanificados() async {
    try {
      isLoading(true);
      errorMessage.value = '';
      final userId = await _getUserId();
      if (userId == 0) {
        errorMessage.value = "Usuario no identificado";
        return;
      }
      var response = await _pagosService.getPagosPlanificados(userId);

      if (response.success && response.data != null) {
        pagosList.assignAll(response.data!);
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

  Future<void> eliminarPago(int id) async {
    try {
      isLoading(true);
      final userId = await _getUserId();
      if (userId == 0) {
        Get.snackbar('Error', 'Usuario no identificado');
        return;
      }
      var response = await _pagosService.deletePagoPlanificado(id, userId);
      if (response.success) {
        pagosList.removeWhere((p) => p.id == id);
        Get.snackbar('Éxito', 'Pago eliminado correctamente');
      } else {
        Get.snackbar('Error', response.message ?? 'No se pudo eliminar');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error al eliminar: $e');
    } finally {
      isLoading(false);
    }
  }
}
