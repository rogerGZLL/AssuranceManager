import 'package:assurance/constants/strings.dart';
import 'package:assurance/utils/utils.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final TextEditingController _tecNombre = TextEditingController();
  TextEditingController get tecNombre => _tecNombre;
  final TextEditingController _tecEmail = TextEditingController();
  TextEditingController get tecEmail => _tecEmail;
  final TextEditingController _tecTelefono = TextEditingController();
  TextEditingController get tecTelefono => _tecTelefono;
  final TextEditingController _tecPassword = TextEditingController();
  TextEditingController get tecPassword => _tecPassword;
  final TextEditingController _tecPasswordConfirm = TextEditingController();
  TextEditingController get tecPasswordConfirm => _tecPasswordConfirm;
  bool _termsAndConditions = false;
  bool get termsAndConditions => _termsAndConditions;

  @override
  void onReady() {
    super.onReady();
  }

  void registrarUsuario() {
    if (validarRegistro()) {}
  }

  bool validarRegistro() {
    bool valido = true;

    if (_tecNombre.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorNombreEmpty);
    } else if (_tecEmail.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorCorreoEmpty);
    } else if (!Utils.isEmail(_tecEmail.text.trim())) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorCorreoFormat);
    } else if (_tecTelefono.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorTelefonoEmpty);
    } else if (_tecTelefono.text.trim().length != 10) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorTelefonoFormat);
    } else if (_tecPassword.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPasswordEmpty);
    } else if (_tecPassword.text.length < 6) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPasswordFormat);
    } else if (_tecPasswordConfirm.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPasswordConfirmEmpty);
    } else if (_tecPasswordConfirm.text != _tecPassword.text) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPasswordConfirmFormat);
    } else if (!_termsAndConditions) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sAceptaTerminosYCondiciones);
    }

    return valido;
  }

  void registrarUsuarioFirebase() {}

  void setTermsAndConditions(bool value) {
    _termsAndConditions = value;
    update();
  }
}
