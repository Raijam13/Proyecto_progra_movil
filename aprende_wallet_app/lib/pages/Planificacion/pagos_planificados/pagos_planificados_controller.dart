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
      var response = await _pagosService.getPagosPlanificados();

      if (response.success && response.data != null) {
        pagosList.assignAll(response.data!);
      } else {
        errorMessage.value =
            response.message ?? "Ocurrió un error al cargar los datos.";
      }
    } finally {
      isLoading(false);
    }
  }
}