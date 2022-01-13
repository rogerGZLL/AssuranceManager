import 'package:assurance/controllers/global_controller_usuario.dart';
import 'package:assurance/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class InicioController extends GetxController {
  GlobalControllerUsuario globalControllerUsuario =
      Get.find<GlobalControllerUsuario>();
  HomeController homeController = Get.find<HomeController>();

  @override
  void onReady() {
    super.onReady();
  }

  void toPerfil() {
    homeController.setIndex(1);
  }
}
