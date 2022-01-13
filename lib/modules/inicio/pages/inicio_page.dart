import 'package:assurance/modules/inicio/controllers/inicio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InicioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
        init: InicioController(),
        builder: (_) {
          return Scaffold();
        });
  }
}
