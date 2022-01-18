import 'package:assurance/controllers/global_controller_usuario.dart';
import 'package:assurance/modules/home/controllers/home_controller.dart';
import 'package:assurance/modules/inicio_notas/pages/notas_page.dart';
import 'package:get/get.dart';

class InicioController extends GetxController {
  GlobalControllerUsuario globalControllerUsuario =
      Get.find<GlobalControllerUsuario>();
  HomeController homeController = Get.find<HomeController>();

  @override
  void onReady() {
    super.onReady();
  }

  void toRoutes(String route) {
    switch (route) {
      case 'misPolizas':
        break;
      case 'misClientes':
        break;
      case 'polizasPendientes':
        break;
      case 'gastosIngresos':
        break;
      case 'notas':
        Get.to(() => NotasPage());
        break;
      case 'miActividad':
        break;
    }
  }

  void toPerfil() {
    homeController.setIndex(1);
  }
}
