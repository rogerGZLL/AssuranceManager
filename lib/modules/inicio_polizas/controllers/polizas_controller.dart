import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/inicio_polizas/pages/crear_poliza_page.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PolizasController extends GetxController {
  //Poliza
  TextEditingController tecNumeroPoliza = TextEditingController();
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
  ProgressDialog progressDialog;

  @override
  void onReady() {
    super.onReady();
    progressDialog = UtilsDialog.showProgresDialog(Get.overlayContext, false);
  }

  void crearPoliza() {
    if (validarDatosPoliza()) {}
  }

  void crearPolizaFirebase() {}

  bool validarDatosPoliza() {
    bool valido = true;
    if (tecNumeroPoliza.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaNumero);
    } else if (tecRamo.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaRamo);
    } else if (tecAseguradora.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaAseguradora);
    } else if (tecCobertura.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaCobertura);
    } else if (tecInciso.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaInciso);
    } else if (tecFechaInicio.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaFechaInicio);
    } else if (tecFechaTerminacion.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaFechaTerminacion);
    } else if (tecFechaEmision.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaFechaEmision);
    } else if (tecFechaPago.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaFechaPago);
    } else if (tecFormaPago.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaFormaPago);
    } else if (tecEstatus.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaEstatus);
    } else if (tecRamo.text == 'Auto') {
      if (validarDatosAutomovil()) {
        valido = validarDatosAutomovil();
      }
    }
    return valido;
  }

  bool validarDatosAutomovil() {
    bool valido = true;
    if (tecAutoMarca.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaMarca);
    } else if (tecAutoTipo.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaTipoAuto);
    } else if (tecAutoModelo.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaModeloAuto);
    } else if (tecAutoSerie.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaSerieAuto);
    } else if (tecAutoMotor.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaMotorAuto);
    } else if (tecAutoPlacas.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaPlacasAuto);
    } else if (tecAutoResidente.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaResidenteAuto);
    } else if (tecAutoLegalizado.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaLegalizadoAuto);
    }
    return valido;
  }

  void selectType(int value) {
    _segmentedControlValue = value;
    update();
  }

  void toAddPoliza() {
    _segmentedControlValue == 0 ? Get.to(() => CrearPolizaPage()) : null;
  }
}
