import 'package:assurance/Firebase/firebase_errors.dart';
import 'package:assurance/Firebase/firebase_services.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/controllers/global_controller_usuario.dart';
import 'package:assurance/models/cliente_model.dart';
import 'package:assurance/modules/inicio_clientes/pages/crear_cliente_page.dart';
import 'package:assurance/modules/inicio_clientes/pages/widgets/modal_date.dart';
import 'package:assurance/utils/utils.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ClientesController extends GetxController {
  GlobalControllerUsuario globalControllerUsuario =
      Get.find<GlobalControllerUsuario>();
  final TextEditingController _tecNombre = TextEditingController();
  TextEditingController get tecNombre => _tecNombre;
  final TextEditingController _tecEmail = TextEditingController();
  TextEditingController get tecEmail => _tecEmail;
  final TextEditingController _tecTelefono = TextEditingController();
  TextEditingController get tecTelefono => _tecTelefono;
  final TextEditingController _tecFechaNacimiento = TextEditingController();
  TextEditingController get tecFechaNacimiento => _tecFechaNacimiento;
  final TextEditingController _tecRFC = TextEditingController();
  TextEditingController get tecRFC => _tecRFC;
  List<Cliente> _listCliente = [];
  List<Cliente> get listCliente => _listCliente;
  bool _cargando = true;
  bool get cargando => _cargando;
  String _birthDay = '';
  ProgressDialog progressDialog;

  @override
  void onReady() {
    super.onReady();
    obtenerClientes();
    progressDialog = UtilsDialog.showProgresDialog(Get.overlayContext, true);
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
      _cargando = false;
      update();
    });
  }

  void crearCliente() {
    if (validarDatosCliente()) {
      crearClienteFirebase();
    }
  }

  void crearClienteFirebase() {
    progressDialog.show();
    Map value = {
      'nombre': _tecNombre.text,
      'correo': _tecEmail.text,
      'telefono': _tecTelefono.text,
      'fechaNacimiento': _tecFechaNacimiento.text,
      'rfc': _tecRFC.text.isEmpty ? '' : _tecRFC.text,
      'fechaCreado': DateTime.now().millisecondsSinceEpoch,
      'fechaModificado': DateTime.now().millisecondsSinceEpoch,
      'fechaEliminado': DateTime.now().millisecondsSinceEpoch,
    };
    FirebaseServices.databaseReference
        .child('clientes')
        .child(globalControllerUsuario.usuario.uid)
        .push()
        .set(value)
        .then((value) {
      obtenerClientes();
      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        progressDialog.hide().whenComplete(() {
          cleanInputsCreate();
          Get.back();
        });
      });
    }).catchError((onError) {
      closeDialogError(FirebaseErrors.erroresFirebase(onError.toString()));
    });
  }

  void closeDialogError(String error) {
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      progressDialog.hide().whenComplete(() {
        UtilsDialog.alertDialogError(Get.overlayContext, error);
      });
    });
  }

  void cleanInputsCreate() {
    _tecNombre.clear();
    _tecEmail.clear();
    _tecTelefono.clear();
    _tecFechaNacimiento.clear();
    _tecRFC.clear();
  }

  bool validarDatosCliente() {
    bool valido = true;
    if (_tecNombre.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorNombreCliente);
    } else if (_tecEmail.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorEmailCliente);
    } else if (!Utils.isEmail(_tecEmail.text.trim())) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorEmailClienteFormat);
    } else if (_tecTelefono.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorTelefonoCliente);
    } else if (_tecFechaNacimiento.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorFechaCliente);
    }
    return valido;
  }

  void showModalBirthDate() {
    showCupertinoModalPopup(
        context: Get.overlayContext,
        builder: (_) {
          return const ModalDate();
        });
  }

  void setDateBirth(String date) {
    _birthDay = date.split(' ')[0];
    String day = _birthDay.split('-')[2];
    String month = _birthDay.split('-')[1];
    String year = _birthDay.split('-')[0];
    _tecFechaNacimiento.text = day + '-' + month + '-' + year;
  }

  void toCreateCliente() {
    Get.to(() => CrearClientePage());
  }
}
