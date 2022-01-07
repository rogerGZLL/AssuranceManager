import 'package:assurance/constants/strings.dart';
import 'package:assurance/utils/utils.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController _tecEmail = TextEditingController();
  TextEditingController get tecEmail => _tecEmail;
  TextEditingController _tecPassword = TextEditingController();
  TextEditingController get tecPassword => _tecPassword;

  @override
  void onReady() {
    super.onReady();
  }

  void login() {
    if (validarDatos()) {}
  }

  void loginFirebase() {}

  bool validarDatos() {
    bool valido = true;
    if (_tecEmail.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorCorreoEmpty);
    } else if (_tecPassword.text.isEmpty) {
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPasswordEmpty);
    } else if (!Utils.isEmail(_tecEmail.text.trim())) {
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorCorreoFormat);
    }
    return valido;
  }
}
