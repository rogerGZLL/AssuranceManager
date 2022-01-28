import 'package:assurance/modules/inicio_polizas/pages/crear_poliza_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PolizasController extends GetxController {
  //Poliza
  TextEditingController tecPoliza = TextEditingController();
  TextEditingController tecCobertura = TextEditingController();
  TextEditingController tecRamo = TextEditingController();
  TextEditingController tecAseguradora = TextEditingController();
  TextEditingController tecInciso = TextEditingController();
  TextEditingController tecFechaInicio = TextEditingController();
  TextEditingController tecFechaTerminacion = TextEditingController();
  TextEditingController tecFechaEmision = TextEditingController();
  TextEditingController tecFechaPago = TextEditingController();
  TextEditingController tecFormaPago = TextEditingController();
  TextEditingController tecMontoTotal = TextEditingController();
  TextEditingController tecEstatus = TextEditingController();
  //Cliente
  TextEditingController tecCliente = TextEditingController();
  //Automóvil
  TextEditingController tecAutoMarca = TextEditingController();
  TextEditingController tecAutoTipo = TextEditingController();
  TextEditingController tecAutoModelo = TextEditingController();
  TextEditingController tecAutoSerie = TextEditingController();
  TextEditingController tecAutoMotor = TextEditingController();
  TextEditingController tecAutoPlacas = TextEditingController();
  TextEditingController tecAutoResidente = TextEditingController();
  TextEditingController tecAutoLegalizado = TextEditingController();
  TextEditingController tecAutoAdaptaciones = TextEditingController();
  int _segmentedControlValue = 0;
  int get segmentedControlValue => _segmentedControlValue;

  @override
  void onReady() {
    super.onReady();
  }

  void selectType(int value) {
    _segmentedControlValue = value;
    update();
  }

  void toAddPoliza() {
    _segmentedControlValue == 0 ? Get.to(() => CrearPolizaPage()) : null;
  }
}
