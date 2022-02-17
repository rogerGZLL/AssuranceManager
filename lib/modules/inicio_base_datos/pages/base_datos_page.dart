import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/inicio_base_datos/controllers/base_datos_controller.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseDatosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseDatosController>(
        init: BaseDatosController(),
        builder: (_) {
          return Scaffold(
            appBar: WidgetAppBarMain(
                appBar: AppBar(),
                title: Strings.sBaseDatos,
                isBack: true,
                back: () => Get.back()),
          );
        });
  }
}
