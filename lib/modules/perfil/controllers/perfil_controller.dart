import 'dart:io';

import 'package:assurance/Firebase/firebase_errors.dart';
import 'package:assurance/Firebase/firebase_references.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/controllers/global_controller_usuario.dart';
import 'package:assurance/modules/perfil/pages/perfil_page_edit.dart';
import 'package:assurance/utils/utils.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PerfilController extends GetxController {
  GlobalControllerUsuario globalControllerUsuario =
      Get.find<GlobalControllerUsuario>();
  TextEditingController _tecNombre = TextEditingController();
  TextEditingController get tecNombre => _tecNombre;
  TextEditingController _tecCorreo = TextEditingController();
  TextEditingController get tecCorreo => _tecCorreo;
  TextEditingController _tecTelefono = TextEditingController();
  TextEditingController get tecTelefono => _tecTelefono;
  TextEditingController _tecRFC = TextEditingController();
  TextEditingController get tecRFC => _tecRFC;
  bool correoBirthday;
  bool correoChristmas;
  bool correoNewYear;
  bool correoRecordatorioPagos;
  File _image;
  File get image => _image;
  ProgressDialog _progressDialog;

  @override
  void onReady() {
    super.onReady();
    _progressDialog = UtilsDialog.showProgresDialog(Get.overlayContext, true);
    initData();
  }

  void initData() {
    _tecNombre.text = globalControllerUsuario.usuario.nombre;
    _tecCorreo.text = globalControllerUsuario.usuario.correo;
    _tecTelefono.text = globalControllerUsuario.usuario.telefono;
    _tecRFC.text = globalControllerUsuario.usuario.rfc;
    correoBirthday = globalControllerUsuario.usuario.correoBirthday;
    correoChristmas = globalControllerUsuario.usuario.correoChristmas;
    correoNewYear = globalControllerUsuario.usuario.correoNewYear;
    correoRecordatorioPagos =
        globalControllerUsuario.usuario.correoRecordatorioPagos;
  }

  void selectImage() {
    showCupertinoModalPopup(
        context: Get.overlayContext,
        builder: (_) => CupertinoActionSheet(
              title: Text(Strings.sFotoSelect),
              actions: [
                CupertinoActionSheetAction(
                  child: Text(Strings.sFotoCamara),
                  onPressed: () {
                    Get.back();
                    getImage(ImageSource.camera);
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text(Strings.sFotoGaleria),
                  onPressed: () {
                    Get.back();
                    getImage(ImageSource.gallery);
                  },
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: Text('Cancelar'),
                onPressed: () => Get.back(),
              ),
            ));
  }

  Future getImage(ImageSource imageSource) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile imagePick =
        await _picker.pickImage(source: imageSource, imageQuality: 100);

    if (imagePick != null) {
      _image = File(imagePick.path);
      print(_image.lengthSync());
      _image = await Utils.testCompressAndGetFile(
        _image,
      );
      print(_image.lengthSync());
      uploadAvatarStorage();
    }
  }

  void uploadAvatarStorage() {
    _progressDialog.show();
    FirebaseReferences.stRefAgentesSeguro
        .child(globalControllerUsuario.usuario.uid)
        .child('avatar')
        .putFile(_image)
        .then((snap) {
      snap.ref.getDownloadURL().then((url) {
        uploadAvatarDatabase(url);
      });
    }).catchError((onError) {
      hideDialogAndShowErrores(onError.toString());
      //UtilsDialog.hideDialog(_progressDialog);
    });
  }

  void uploadAvatarDatabase(String url) {
    FirebaseReferences.dbRefAgentesSeguro
        .child(globalControllerUsuario.usuario.uid)
        .update({'avatar': url}).then((value) {
      Future.delayed(Duration(milliseconds: 100)).then((value) {
        _progressDialog.hide().whenComplete(() {
          globalControllerUsuario.usuario.avatar = url;
          update();
        });
      });
    }).catchError((onError) {
      hideDialogAndShowErrores(onError.toString());
      //UtilsDialog.hideDialog(_progressDialog);
    });
  }

  void saveData() {
    if (validarDatos()) {
      uploadDataFirebase();
    }
  }

  void uploadDataFirebase() {
    _progressDialog.show();
    final data = {
      'nombre': _tecNombre.text,
      'telefono': _tecTelefono.text,
      'rfc': _tecRFC.text,
      /* 'correoBirthday': correoBirthday,
      'correoChristmas': correoChristmas,
      'correoNewYear': correoNewYear,
      'correoRecordatorioPagos': correoRecordatorioPagos,*/
      'fechaModificado': DateTime.now().millisecondsSinceEpoch,
      'correoNewYear': false,
      'correoBirthday': false,
      'correoChristmas': false,
      'correoRecordatorioPagos': false,
    };
    FirebaseReferences.dbRefAgentesSeguro
        .child(globalControllerUsuario.usuario.uid)
        .update(data)
        .then((value) {
      Future.delayed(Duration(milliseconds: 100)).then((value) {
        _progressDialog.hide().whenComplete(() {
          saveDataUserController();
        });
      });
    }).catchError((onError) {
      hideDialogAndShowErrores(onError.toString());
      //UtilsDialog.hideDialog(_progressDialog);
    });
  }

  void saveDataUserController() {
    globalControllerUsuario.usuario.nombre = _tecNombre.text;
    globalControllerUsuario.usuario.telefono = _tecTelefono.text;
    globalControllerUsuario.usuario.rfc = _tecRFC.text;
    globalControllerUsuario.usuario.correoBirthday = correoBirthday;
    globalControllerUsuario.usuario.correoChristmas = correoChristmas;
    globalControllerUsuario.usuario.correoNewYear = correoNewYear;
    globalControllerUsuario.usuario.correoRecordatorioPagos =
        correoRecordatorioPagos;
    update();
    Get.back();
  }

  bool validarDatos() {
    bool valido = true;
    if (_tecNombre.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorNombreEmpty);
    } else if (_tecTelefono.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorTelefonoEmpty);
    } else if (_tecTelefono.text.trim().length != 10) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorTelefonoFormat);
    }
    return valido;
  }

  void hideDialogAndShowErrores(String error) {
    Future.delayed(Duration(milliseconds: 300)).then((value) {
      _progressDialog.hide().whenComplete(() {
        UtilsDialog.alertDialogError(
          Get.overlayContext,
          FirebaseErrors.erroresFirebase(error),
        );
      });
    });
  }

  void toEditProfile() {
    Get.to(() => PerfilPageEdit());
  }

  void onBack() {
    initData();
    Get.back();
  }
}
