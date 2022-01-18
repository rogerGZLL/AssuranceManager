import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/inicio_clientes/controllers/clientes_controller.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PolizasPendientesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientesController>(
        init: ClientesController(),
        builder: (_) {
          return Scaffold(
            appBar: WidgetAppBarMain(
                appBar: AppBar(),
                title: Strings.sMisClientes,
                isBack: true,
                back: () => Get.back()),
          );
        });
  }
}
