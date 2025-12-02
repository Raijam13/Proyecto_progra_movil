import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:aprende_wallet_app/pages/Planificacion/pagos_planificados/pagos_planificados_page.dart';
import 'package:aprende_wallet_app/pages/Planificacion/pagos_planificados/pagos_planificados_controller.dart';
import 'package:aprende_wallet_app/models/pago_planificado_model.dart';

// Mock Controller
class MockPagosController extends GetxController implements PagosPlanificadosController {
  @override
  RxBool isLoading = false.obs;
  @override
  RxList<PagoPlanificado> pagosList = <PagoPlanificado>[].obs;
  @override
  RxString errorMessage = ''.obs;

  @override
  void fetchPagosPlanificados() {}
  
  @override
  Future<void> eliminarPago(int id) async {}
}

void main() {
  tearDown(() {
    Get.reset();
  });

  testWidgets('PagosPlanificadosPage shows empty state when list is empty', (WidgetTester tester) async {
    // Arrange
    final mockController = MockPagosController();
    Get.put<PagosPlanificadosController>(mockController); // Register mock

    // Act
    await tester.pumpWidget(const GetMaterialApp(home: PagosPlanificadosPage()));

    // Assert
    expect(find.text('Pagos Planificados'), findsOneWidget);
    expect(find.text('Ten tus próximos pagos en un solo lugar'), findsOneWidget); // Empty state text
  });

  testWidgets('PagosPlanificadosPage shows list when data exists', (WidgetTester tester) async {
    // Arrange
    final mockController = MockPagosController();
    mockController.pagosList.add(PagoPlanificado(
      id: 1,
      nombre: 'Netflix',
      monto: 50.0,
      tipo: 'gasto',
      periodo: 'Mensual',
      categoria: 'Suscripciones',
      proximaFecha: DateTime.now(),
    ));
    Get.put<PagosPlanificadosController>(mockController);

    // Act
    await tester.pumpWidget(const GetMaterialApp(home: PagosPlanificadosPage()));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Netflix'), findsOneWidget);
    expect(find.text('Suscripciones'), findsNothing); // Subtitle format might differ
    expect(find.textContaining('Mensual'), findsOneWidget);
  });
}
