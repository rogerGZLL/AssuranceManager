import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/inicio_polizas/controllers/polizas_controller.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:assurance/widgets/widget_button_main.dart';
import 'package:assurance/widgets/widget_input_main.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:assurance/widgets/widget_selector_main.dart';
import 'package:assurance/widgets/widget_text_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrearPolizaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PolizasController>(
        init: PolizasController(),
        builder: (_) {
          return Scaffold(
              appBar: WidgetAppBarMain(
                  appBar: AppBar(),
                  title: Strings.sCrearPoliza,
                  isBack: true,
                  back: () => Get.back()),
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24),
                physics: BouncingScrollPhysics(),
                children: [
                  WidgetInputMain(
                      enabled: true,
                      textCapitalization: TextCapitalization.none,
                      obscureText: false,
                      tit: TextInputType.text,
                      tec: _.tecPoliza,
                      hintText: Strings.sNumeroPoliza),
                  WidgetSelectorMain(
                      label: true,
                      enabled: true,
                      tec: _.tecRamo,
                      hintText: Strings.sRamoPoliza),
                  WidgetSelectorMain(
                      label: true,
                      enabled: true,
                      tec: _.tecAseguradora,
                      hintText: Strings.sAseguradoraPoliza),
                  WidgetInputMain(
                      enabled: true,
                      textCapitalization: TextCapitalization.none,
                      obscureText: false,
                      tit: TextInputType.text,
                      tec: _.tecCobertura,
                      hintText: Strings.sCoberturaPoliza),
                  WidgetInputMain(
                      enabled: true,
                      textCapitalization: TextCapitalization.none,
                      obscureText: false,
                      tit: TextInputType.text,
                      tec: _.tecInciso,
                      hintText: Strings.sIncisoPoliza),
                  WidgetSelectorMain(
                      label: true,
                      enabled: true,
                      tec: _.tecFechaInicio,
                      hintText: Strings.sInicioPoliza),
                  WidgetSelectorMain(
                      label: true,
                      enabled: true,
                      tec: _.tecFechaTerminacion,
                      hintText: Strings.sTerminacionPoliza),
                  WidgetSelectorMain(
                      label: true,
                      enabled: true,
                      tec: _.tecFechaEmision,
                      hintText: Strings.sEmisionPoliza),
                  WidgetSelectorMain(
                      label: true,
                      enabled: true,
                      tec: _.tecFechaPago,
                      hintText: Strings.sPagoPoliza),
                  WidgetInputMain(
                      enabled: true,
                      textCapitalization: TextCapitalization.none,
                      obscureText: false,
                      tit: TextInputType.text,
                      tec: _.tecFormaPago,
                      hintText: Strings.sFormaPago),
                  WidgetInputMain(
                      enabled: true,
                      textCapitalization: TextCapitalization.none,
                      obscureText: false,
                      tit: TextInputType.text,
                      tec: _.tecFormaPago,
                      hintText: Strings.sMontoPago),
                  //Cliente
                  Column(
                    children: [
                      WidgetMargin(margin: 8),
                      WidgetTextMain(
                          text: Strings.sCliente,
                          paddingHorizontal: 24,
                          paddingVertical: 16),
                      WidgetSelectorMain(
                          label: true,
                          enabled: true,
                          tec: _.tecCliente,
                          hintText: Strings.sClienteExistente),
                      WidgetSelectorMain(
                          label: true,
                          enabled: true,
                          tec: null,
                          hintText: Strings.sClienteNuevo),
                    ],
                  ),
                  //Automóvil
                  Column(
                    children: [
                      WidgetMargin(margin: 8),
                      WidgetTextMain(
                          text: Strings.sAutomovil,
                          paddingHorizontal: 24,
                          paddingVertical: 16),
                      WidgetInputMain(
                          enabled: true,
                          textCapitalization: TextCapitalization.none,
                          obscureText: false,
                          tit: TextInputType.text,
                          tec: _.tecAutoMarca,
                          hintText: Strings.sAutomovilMarca),
                      WidgetSelectorMain(
                          label: true,
                          enabled: true,
                          tec: _.tecAutoTipo,
                          hintText: Strings.sAutomovilTipo),
                      WidgetInputMain(
                          enabled: true,
                          textCapitalization: TextCapitalization.none,
                          obscureText: false,
                          tit: TextInputType.text,
                          tec: _.tecAutoModelo,
                          hintText: Strings.sAutomovilModelo),
                      WidgetInputMain(
                          enabled: true,
                          textCapitalization: TextCapitalization.none,
                          obscureText: false,
                          tit: TextInputType.text,
                          tec: _.tecAutoSerie,
                          hintText: Strings.sAutomovilSerie),
                      WidgetInputMain(
                          enabled: true,
                          textCapitalization: TextCapitalization.none,
                          obscureText: false,
                          tit: TextInputType.text,
                          tec: _.tecAutoMotor,
                          hintText: Strings.sAutomovilMotor),
                      WidgetInputMain(
                          enabled: true,
                          textCapitalization: TextCapitalization.none,
                          obscureText: false,
                          tit: TextInputType.text,
                          tec: _.tecAutoPlacas,
                          hintText: Strings.sAutomovilPlacas),
                      WidgetSelectorMain(
                          label: true,
                          enabled: true,
                          tec: _.tecAutoResidente,
                          hintText: Strings.sAutomovilResidente),
                      WidgetSelectorMain(
                          label: true,
                          enabled: true,
                          tec: _.tecAutoLegalizado,
                          hintText: Strings.sAutomovilLegalizado),
                    ],
                  ),
                  WidgetButtonMain(
                      text: Strings.sGuardar,
                      paddingHorizontal: 0,
                      paddingVertical: 24,
                      fun: () {})
                ],
              ));
        });
  }
}
