import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/perfil/controllers/perfil_controller.dart';
import 'package:assurance/modules/perfil/pages/widgets/item_perfil_preference.dart';
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
              hintText: Strings.sRFC),
          WidgetMargin(margin: 32),
          ItemPerfilPreference(
              title: Strings.sCorreoBirthday,
              enable: _.correoBirthday,
              type: 'correoBirthday'),
          WidgetMargin(margin: 16),
          ItemPerfilPreference(
              title: Strings.sCorreoChristmas,
              enable: _.correoChristmas,
              type: 'correoChristmas'),
          WidgetMargin(margin: 16),
          ItemPerfilPreference(
              title: Strings.sCorreoNewYear,
              enable: _.correoNewYear,
              type: 'correoNewYear'),
          WidgetMargin(margin: 16),
          ItemPerfilPreference(
              title: Strings.sCorreoRecordatorioPagos,
              enable: _.correoRecordatorioPagos,
              type: 'correoRecordatorioPagos'),
        ],
      );
    });
  }
}
