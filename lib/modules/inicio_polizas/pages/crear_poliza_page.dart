import 'package:assurance/constants/constants.dart';
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
                      tec: _.tecNumeroPoliza,
                      hintText: Strings.sNumeroPoliza),
                  WidgetSelectorMain(
                      fun: () => _.showModalGeneric(
                          'ramo', Strings.sErrorPolizaRamo, _.listRamo),
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
                  WidgetSelectorMain(
                      fun: () => _.showModalGeneric('estatus',
                          Strings.sErrorPolizaEstatus, _.listEstatus),
                      label: true,
                      enabled: true,
                      tec: _.tecEstatus,
                      hintText: Strings.sPolizaEstatus),
                  WidgetInputMain(
                      enabled: true,
                      textCapitalization: TextCapitalization.none,
                      obscureText: false,
                      tit: TextInputType.text,
                      tec: _.tecMontoTotal,
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
                          fun: () => _.showModalClientes(_.listCliente),
                          label: true,
                          enabled: true,
                          tec: _.tecCliente,
                          hintText: Strings.sClienteExistente),
                    ],
                  ),
                  //Automóvil
                  _.tecRamo.text == Constants.ramoAuto
                      ? Column(
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
                                fun: () => _.showModalGeneric(
                                    'tipoAuto',
                                    Strings.sErrorPolizaTipoAuto,
                                    _.listTipoAuto),
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
                                fun: () => _.showModalGeneric(
                                    'residente',
                                    Strings.sErrorPolizaResidenteAuto,
                                    _.listSiNo),
                                label: true,
                                enabled: true,
                                tec: _.tecAutoResidente,
                                hintText: Strings.sAutomovilResidente),
                            WidgetSelectorMain(
                                fun: () => _.showModalGeneric(
                                    'legalizado',
                                    Strings.sErrorPolizaLegalizadoAuto,
                                    _.listSiNo),
                                label: true,
                                enabled: true,
                                tec: _.tecAutoLegalizado,
                                hintText: Strings.sAutomovilLegalizado),
                            WidgetInputMain(
                                enabled: true,
                                textCapitalization: TextCapitalization.none,
                                obscureText: false,
                                tit: TextInputType.text,
                                tec: _.tecAutoAdaptaciones,
                                hintText: Strings.sAutomovilAdaptaciones),
                          ],
                        )
                      : Container(),
                  WidgetButtonMain(
                      text: Strings.sGuardar,
                      paddingHorizontal: 0,
                      paddingVertical: 24,
                      fun: _.crearPoliza)
                ],
              ));
        });
  }
}
