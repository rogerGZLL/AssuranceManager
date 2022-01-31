import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/inicio_polizas/controllers/polizas_controller.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgregarDocumentosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PolizasController>(builder: (_) {
      return Scaffold(
        appBar: WidgetAppBarMain(
            appBar: AppBar(),
            title: Strings.sAgregregarArchivos,
            isBack: true,
            back: () => Get.back()),
      );
    });
  }
}
