import 'package:assurance/Firebase/firebase_services.dart';
import 'package:assurance/constants/constants.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/controllers/global_controller_usuario.dart';
import 'package:assurance/models/aseguradora_model.dart';
import 'package:assurance/models/cliente_model.dart';
import 'package:assurance/models/poliza_model.dart';
import 'package:assurance/modules/inicio_clientes/pages/crear_cliente_page.dart';
import 'package:assurance/modules/inicio_polizas/pages/agregar_documentos_page.dart';
import 'package:assurance/modules/inicio_polizas/pages/crear_poliza_page.dart';
import 'package:assurance/modules/inicio_polizas/pages/polizas_widgets.dart/modal_aseguradoras_polizas.dart';
import 'package:assurance/modules/inicio_polizas/pages/polizas_widgets.dart/modal_clientes_polizas.dart';
import 'package:assurance/modules/inicio_polizas/pages/polizas_widgets.dart/modal_date_polizas.dart';
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
  //Polizas
  List<Poliza> _listPoliza = [];
  List<Poliza> get listPoliza => _listPoliza;
  bool cargando = true;
  //Clientes
  List<Cliente> _listCliente = [];
  List<Cliente> get listCliente => _listCliente;
  Cliente clienteSelected = Cliente();
  //Aseguradoras
  List<Aseguradora> _listAseguradora = [];
  List<Aseguradora> get listAseguradora => _listAseguradora;
  Aseguradora aseguradoraSelected = Aseguradora();
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
    obtenerPolizas();
    obtenerAseguradoras();
    progressDialog = UtilsDialog.showProgresDialog(Get.overlayContext, false);
  }

  void obtenerPolizas() {
    _listPoliza.clear();
    FirebaseServices.databaseReference
        .child('polizas')
        .child(globalControllerUsuario.usuario.uid)
        .once()
        .then((snap) {
      _listPoliza.clear();
      if (snap.exists) {
        snap.value.forEach((key, value) {
          _listPoliza.add(Poliza.fromJson(key, value));
        });
        _listPoliza.forEach((el) {
          print(el.numero);
        });
      }
      cargando = false;
      update();
    });
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
    _listAseguradora.clear();
    FirebaseServices.databaseReference
        .child('aseguradoras')
        .orderByChild('nombre')
        .once()
        .then((snap) {
      _listAseguradora.clear();
      if (snap.exists) {
        snap.value.forEach((key, value) {
          _listAseguradora.add(Aseguradora.fromJson(key, value));
        });
      }
      update();
    });
  }

  void crearPoliza() {
    if (validarDatosPoliza()) {
      crearPolizaFirebase();
    }
  }

  void crearPolizaFirebase() {
    progressDialog.show();
    String idPoliza = FirebaseServices.databaseReference.push().key;
    Map auto = {
      'marca': tecAutoMarca.text,
      'tipo': tecAutoTipo.text,
      'modelo': tecAutoModelo.text,
      'serie': tecAutoSerie.text,
      'motor': tecAutoMotor.text,
      'placas': tecAutoPlacas.text,
      'esResidente': tecAutoResidente.text,
      'esLegalizado': tecAutoLegalizado.text,
      'adaptaciones': tecAutoAdaptaciones.text
    };
    Map value = {
      'numero': tecNumeroPoliza.text,
      'ramo': tecRamo.text,
      'aseguradora': tecAseguradora.text,
      'cobertura': tecCobertura.text,
      'inciso': tecInciso.text,
      'fechaInicio': tecFechaInicio.text,
      'fechaTerminacion': tecFechaTerminacion.text,
      'fechaEmision': tecFechaEmision.text,
      'fechaPago': tecFechaPago.text,
      'formaPago': tecFormaPago.text,
      'estatus': tecEstatus.text,
      'montoTotal': tecMontoTotal.text,
      'clienteID': clienteSelected.id,
      'clienteNombre': clienteSelected.nombre,
    };
    if (tecRamo.text == 'Auto') value['auto'] = auto;
    print(value);
    FirebaseServices.databaseReference
        .child('polizas')
        .child(globalControllerUsuario.usuario.uid)
        .child(idPoliza)
        .set(value)
        .then((value) {
      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        progressDialog.hide().whenComplete(() {
          UtilsDialog.alertDialogTwoActions(
              Get.overlayContext,
              Strings.sPolizaGuardada,
              Strings.sPolizaGuardadaText,
              Strings.sNo,
              Strings.sAgregregarArchivos, () {
            Get.back();
            Get.back();
          }, () {
            Get.back();
            toAgregarArchivos(idPoliza);
          });
        });
      });
    }).catchError((onError) {});
  }

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
    } else if (tecMontoTotal.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaMontoTotal);
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

  void showModalAseguradora(List<Aseguradora> listAseguradora) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        context: Get.overlayContext,
        builder: (_) {
          return ModalAseguradorasPolizas(
            aseguradoras: listAseguradora,
          );
        });
  }

  void showModalDatePolizas(String type) {
    showCupertinoModalPopup(
        context: Get.overlayContext,
        builder: (_) {
          return ModalDatePolizas(
            type: type,
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

  void setDateBirth(String date, String type) {
    String fecha = date.split(' ')[0];
    String day = fecha.split('-')[2];
    String month = fecha.split('-')[1];
    String year = fecha.split('-')[0];
    switch (type) {
      case 'fechaInicio':
        tecFechaInicio.text = day + '-' + month + '-' + year;
        break;
      case 'fechaTerminacion':
        tecFechaTerminacion.text = day + '-' + month + '-' + year;
        break;
      case 'fechaEmision':
        tecFechaEmision.text = day + '-' + month + '-' + year;
        break;
      case 'fechaPago':
        tecFechaPago.text = day + '-' + month + '-' + year;
        break;
    }
  }

  void selectCliente(Cliente cliente, int index) {
    clienteSelected = cliente;
    tecCliente.text = clienteSelected.nombre;
    Get.back();
  }

  void selectAseguradora(Aseguradora aseguradora, int index) {
    aseguradoraSelected = aseguradora;
    tecAseguradora.text = aseguradoraSelected.nombre;
    Get.back();
  }

  void selectType(int value) {
    _segmentedControlValue = value;
    update();
  }

  void toAddPoliza() {
    _segmentedControlValue == 0 ? Get.to(() => CrearPolizaPage()) : null;
  }

  void toAgregarArchivos(String idPoliza) {
    Get.back();
    Get.to(() => AgregarDocumentosPage());
  }

  void toAddCliente() {
    Get.back();
    Get.to(() => CrearClientePage());
  }
}
