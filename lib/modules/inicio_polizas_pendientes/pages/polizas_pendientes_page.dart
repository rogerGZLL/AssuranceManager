import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/inicio_polizas_pendientes/controllers/polizas_pendientes_controller.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PolizasPendientesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PolizasPendientesController>(
        init: PolizasPendientesController(),
        builder: (_) {
          return Scaffold(
            appBar: WidgetAppBarMain(
                appBar: AppBar(),
                title: Strings.sPolizasPendientes,
                isBack: true,
                back: () => Get.back()),
          );
        });
  }
}
