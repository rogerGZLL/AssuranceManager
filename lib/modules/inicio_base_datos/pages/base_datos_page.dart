import 'package:assurance/constants/constants.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/inicio_base_datos/controllers/base_datos_controller.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:assurance/widgets/widget_margin.dart';
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
            body: Center(
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  onTap: () {
                    _.importarExcel();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          Constants.icExcel,
                          width: 28,
                          height: 28,
                        ),
                        WidgetMargin(margin: 16),
                        Text(Strings.sImportarExcel),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
