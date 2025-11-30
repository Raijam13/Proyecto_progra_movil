import 'package:get/get.dart';
import 'package:aprende_wallet_app/models/pago_planificado_model.dart';
import 'package:aprende_wallet_app/services/pagos_planificados_service.dart';

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

  void fetchPagosPlanificados() async {
    try {
      isLoading(true);
      errorMessage.value = '';
      // TODO: Get real userId
      var response = await _pagosService.getPagosPlanificados(1);

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
      // TODO: Get real userId
      var response = await _pagosService.deletePagoPlanificado(id, 1);
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
