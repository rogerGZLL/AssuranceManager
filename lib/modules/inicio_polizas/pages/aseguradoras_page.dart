import 'package:assurance/modules/inicio_polizas/controllers/polizas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AseguradorasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PolizasController>(
        init: PolizasController(),
        builder: (_) {
          return Center(
            child: Text('Aseguradoras'),
          );
        });
  }
}
