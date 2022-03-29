import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/perfil/controllers/perfil_controller.dart';
import 'package:assurance/modules/perfil/pages/widgets/perfil_edit_data.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:assurance/widgets/widget_button_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerfilPageEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerfilController>(
        init: PerfilController(),
        builder: (_) {
          return WillPopScope(
            onWillPop: () {
              _.onBack();
              return Future.value(false);
            },
            child: Scaffold(
              appBar: WidgetAppBarMain(
                  appBar: AppBar(),
                  title: Strings.sEditarPerfil,
                  isBack: true,
                  back: () => _.onBack()),
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  PerfilEditData(),
                  WidgetButtonMain(
                      text: Strings.sGuardar,
                      paddingHorizontal: 24,
                      paddingVertical: 24,
                      fun: _.saveData)
                ],
              ),
            ),
          );
        });
  }
}
