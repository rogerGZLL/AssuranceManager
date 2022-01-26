import 'dart:io';
import 'dart:js' as js;

import 'package:assurance/Firebase/firebase_errors.dart';
import 'package:assurance/Firebase/firebase_services.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/utils/utils.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:assurance/modules/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:file/file.dart';
import 'dart:async';


class ActualizarBdController extends GetxController {
  final TextEditingController _tecEmail = TextEditingController();
  TextEditingController get tecEmail => _tecEmail;
  final TextEditingController _tecPassword = TextEditingController();
  TextEditingController get tecPassword => _tecPassword;
  final TextEditingController _tecEmailReset = TextEditingController();
  TextEditingController get tecEmailReset => _tecEmailReset;
  ProgressDialog _progressDialog;
  // rv to put attached file
  List files;   // Solo un archivo (el excel)
  List selectedFiles;
  File file;


  @override
  void onReady() {
    super.onReady();
    _progressDialog = UtilsDialog.showProgresDialog(
      Get.overlayContext,
      false,
    );
  }

  //Login
  void login() {
    if (validarLogin()) {
      loginFirebase();
    }
  }

  void loginFirebase() {
    _progressDialog.show();
    FirebaseServices.firebaseAuth
        .signInWithEmailAndPassword(
            email: _tecEmail.text.trim(), password: _tecPassword.text)
        .then((value) => toHomePage())
        .catchError((onError) =>
            errorDialog(FirebaseErrors.erroresFirebase(onError.toString())));
  }

  bool validarLogin() {
    bool valido = true;
    if (_tecEmail.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorCorreoEmpty);
    } else if (_tecPassword.text.isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPasswordEmpty);
    } else if (!Utils.isEmail(_tecEmail.text.trim())) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorCorreoFormat);
    }
    return valido;
  }

  void resetPassword() {
    if (validarResetPassword()) {
      resetPasswordFirebase();
    }
  }

  bool validarResetPassword() {
    bool valido = true;
    if (_tecEmailReset.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorCorreoEmpty);
    } else if (!Utils.isEmail(_tecEmailReset.text.trim())) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorCorreoFormat);
    }
    return valido;
  }

  void resetPasswordFirebase() {
    _progressDialog.show();
    FirebaseServices.firebaseAuth
        .sendPasswordResetEmail(email: _tecEmailReset.text.trim())
        .then((value) {
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        _progressDialog.hide().whenComplete(() {
          UtilsDialog.alertDialogOneAction(Get.overlayContext,
              Strings.sEmailResetSent, Strings.sEmailResetSentContent, () {
            Get.back();
            Get.back();
          });
        });
      });
    }).catchError((onError) =>
            errorDialog(FirebaseErrors.erroresFirebase(onError.toString())));
  }

  void errorDialog(String message) {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      _progressDialog.hide().whenComplete(() {
        UtilsDialog.alertDialogError(Get.overlayContext, message);
      });
    });
  }

  void toHomePage() {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      _progressDialog.hide().whenComplete(() {
        Get.offAll(() => HomePage());
      });
    });
  }




  ////////////////////////////////////////////////////////////////////////////////////


  Future uploadFile() async{
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if(result==null) return;
    final path = result.files.single.path;
    file = File(path);
  }


  void manageRowsColumns(){
    
  }


  void elegirPolizasNoActualizar(){

  }



  void openFile(){

  }


  void longPressFile(){
    
  }


  void cancelar(){
    Get.back();
  }


  ////////////////////////////////////////////////////////////////////////////////////


  void actualizar() {

  }
  
}