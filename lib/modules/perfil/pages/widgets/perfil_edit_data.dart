import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/perfil/controllers/perfil_controller.dart';
import 'package:assurance/widgets/widget_input_main.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class PerfilEditData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerfilController>(builder: (_) {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          WidgetInputMain(
              enabled: true,
              textCapitalization: TextCapitalization.words,
              obscureText: false,
              tit: TextInputType.name,
              tec: _.tecNombre,
              hintText: Strings.sNombreCompleto),
          WidgetMargin(margin: 8),
          WidgetInputMain(
              enabled: true,
              textCapitalization: TextCapitalization.none,
              obscureText: false,
              tit: TextInputType.number,
              tec: _.tecTelefono,
              hintText: Strings.sTelefono),
          WidgetMargin(margin: 8),
          WidgetInputMain(
              enabled: true,
              textCapitalization: TextCapitalization.none,
              obscureText: false,
              tit: TextInputType.text,
              tec: _.tecRFC,
              hintText: Strings.sRFC)
        ],
      );
    });
  }
}
