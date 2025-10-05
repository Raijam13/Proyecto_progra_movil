import 'package:get/get.dart';
import '../Home/home_controller.dart';

class AgregarRegistroController extends GetxController {
  RxString tipo = 'Gasto'.obs; // 'Gasto' o 'Ingreso'
  RxString moneda = 'PEN'.obs;
  RxDouble monto = 0.0.obs;
  RxString cuenta = ''.obs;
  RxString categoria = ''.obs;
  Rx<DateTime> fechaHora = DateTime.now().obs;

  void setTipo(String nuevoTipo) {
    tipo.value = nuevoTipo;
    monto.value = 0.0;
  }

  void setMonto(double nuevoMonto) {
    monto.value = nuevoMonto;
  }

  void setCuenta(String nuevaCuenta) {
    cuenta.value = nuevaCuenta;
  }

  void setCategoria(String nuevaCategoria) {
    categoria.value = nuevaCategoria;
  }

  void setFechaHora(DateTime nuevaFechaHora) {
    fechaHora.value = nuevaFechaHora;
  }

  void guardarRegistro() {
    // Obtén el HomeController
    final homeController = Get.find<HomeController>();
    // Determina el color y tipo
    final isIngreso = tipo.value == 'Ingreso';
    final color = isIngreso ? 0xFF43A047 : 0xFFEF5350; // Verde o rojo
    homeController.agregarTransaccion(
      title: categoria.value.isNotEmpty ? categoria.value : 'Sin categoría',
      subtitle: cuenta.value.isNotEmpty ? cuenta.value : 'Sin cuenta',
      amount: isIngreso ? monto.value : -monto.value,
      date: fechaHora.value,
      type: isIngreso ? 'income' : 'expense',
      color: color,
    );
  // Limpia los valores tras guardar
    tipo.value = 'Gasto';
    moneda.value = 'PEN';
    cuenta.value = '';
    categoria.value = '';
    fechaHora.value = DateTime.now();
    monto.value = 0.0;
  }
}
