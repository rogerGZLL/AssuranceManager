import 'package:assurance/Firebase/firebase_services.dart';
import 'package:assurance/constants/constants.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/controllers/global_controller_usuario.dart';
import 'package:assurance/models/cliente_model.dart';
import 'package:assurance/modules/inicio_clientes/pages/crear_cliente_page.dart';
import 'package:assurance/modules/inicio_polizas/pages/crear_poliza_page.dart';
import 'package:assurance/modules/inicio_polizas/pages/polizas_widgets.dart/modal_clientes_polizas.dart';
import 'package:assurance/modules/inicio_polizas/pages/polizas_widgets.dart/modal_generic_polizas.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PolizasController extends GetxController {
  GlobalControllerUsuario globalControllerUsuario =
      Get.find<GlobalControllerUsuario>();
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
  //Clientes
  List<Cliente> _listCliente = [];
  List<Cliente> get listCliente => _listCliente;
  Cliente clienteSelected = Cliente();
  //Constants
  List<String> listRamo = [
    Constants.ramoAuto,
    Constants.ramoHogar,
    Constants.ramoVida,
    Constants.ramoSalud,
  ];
  List<String> listEstatus = [
    Constants.estatusPagado,
    Constants.estatusPeriodoGracia,
    Constants.estatusVencido,
    Constants.estatusCancelado,
  ];
  List<String> listTipoAuto = [
    Constants.autoCoche,
    Constants.autoMoto,
    Constants.autoCiclomotor,
    Constants.autoFurgoneta,
    Constants.autoPickup,
  ];
  List<String> listSiNo = ['Si', 'No'];

  @override
  void onReady() {
    super.onReady();
    progressDialog = UtilsDialog.showProgresDialog(Get.overlayContext, false);
  }

  void obtenerClientes() {
    _listCliente.clear();
    FirebaseServices.databaseReference
        .child('clientes')
        .child(globalControllerUsuario.usuario.uid)
        .once()
        .then((snap) {
      _listCliente.clear();
      if (snap.exists) {
        snap.value.forEach((key, value) {
          _listCliente.add(Cliente.fromJson(key, value));
        });
      }
      update();
    });
  }

  void obtenerAseguradoras() {
    _listCliente.clear();
    FirebaseServices.databaseReference
        .child('aseguradoras')
        .orderByChild('name')
        .once()
        .then((snap) {
      _listCliente.clear();
      if (snap.exists) {
        snap.value.forEach((key, value) {
          _listCliente.add(Cliente.fromJson(key, value));
        });
      }
      update();
    });
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

  void showModalGeneric(String type, String title, List<String> options) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        context: Get.overlayContext,
        builder: (_) {
          return ModalGenericPolizas(
            type: type,
            title: title,
            options: options,
          );
        });
  }

  void showModalClientes(List<Cliente> listcliente) {
    obtenerClientes();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        context: Get.overlayContext,
        builder: (_) {
          return ModalClientesPolizas(
            clientes: listCliente,
          );
        });
  }

  void selectOption(String type, int index) {
    switch (type) {
      case 'ramo':
        tecRamo.text = listRamo[index];
        Get.back();
        break;
      case 'estatus':
        tecEstatus.text = listEstatus[index];
        Get.back();
        break;
      case 'tipoAuto':
        tecAutoTipo.text = listTipoAuto[index];
        Get.back();
        break;
      case 'residente':
        tecAutoResidente.text = listSiNo[index];
        Get.back();
        break;
      case 'legalizado':
        tecAutoLegalizado.text = listSiNo[index];
        Get.back();
        break;
    }
    update();
  }

  void selectCliente(Cliente cliente, int index) {
    clienteSelected = cliente;
    tecCliente.text = clienteSelected.nombre;
    Get.back();
  }

  void selectType(int value) {
    _segmentedControlValue = value;
    update();
  }

  void toAddPoliza() {
    _segmentedControlValue == 0 ? Get.to(() => CrearPolizaPage()) : null;
  }

  void toAddCliente() {
    Get.back();
    Get.to(() => CrearClientePage());
  }
}
