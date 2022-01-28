import 'package:assurance/modules/inicio_polizas/pages/crear_poliza_page.dart';
import 'package:get/get.dart';

class PolizasController extends GetxController {
  int _segmentedControlValue = 0;
  int get segmentedControlValue => _segmentedControlValue;

  @override
  void onReady() {
    super.onReady();
  }

  void selectType(int value) {
    _segmentedControlValue = value;
    update();
  }

  void toAddPoliza() {
    _segmentedControlValue == 0 ? Get.to(() => CrearPolizaPage()) : null;
  }
}
