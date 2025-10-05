import 'package:get/get.dart';

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
    // Aquí se implementará la lógica para guardar el registro
    print('Registro guardado');
  }
}
