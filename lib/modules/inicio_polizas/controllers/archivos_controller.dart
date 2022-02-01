import 'dart:io';
import 'package:assurance/Firebase/firebase_services.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/controllers/global_controller_usuario.dart';
import 'package:assurance/utils/utils.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ArchivosController extends GetxController {
  GlobalControllerUsuario globalControllerUsuario =
      Get.find<GlobalControllerUsuario>();
  String idPoliza;
  ProgressDialog progressDialog;

  @override
  void onReady() {
    super.onReady();
    progressDialog = UtilsDialog.showProgresDialog(Get.overlayContext, false);
  }

  @override
  void onInit() {
    super.onInit();
    idPoliza = Get.arguments as String;
    print(idPoliza);
  }

  Future<void> selectFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf', 'doc', 'docx', 'xls', 'xlsx']);

    if (result != null) {
      File file = File(result.files.single.path);
      PlatformFile platformFile = result.files.single;
      print(file.lengthSync());
      if (detectTypeFile(platformFile.name) == 'imagen') {
        file = await Utils.testCompressAndGetFile(
          file,
        );
      }
      print(file.lengthSync());
      print(platformFile.name);
      if (detectTypeFile(platformFile.name) != 'invalid') {
        uploadFileStorage(
            file, platformFile.name, detectTypeFile(platformFile.name));
      } else {
        UtilsDialog.alertDialogError(
            Get.overlayContext, Strings.sErrorFormatFile);
      }
    }
  }

  String detectTypeFile(String fileName) {
    String fileType = '';
    if (fileName.toLowerCase().contains('jpg')) {
      fileType = 'imagen';
    } else if (fileName.toLowerCase().contains('jpeg')) {
      fileType = 'imagen';
    } else if (fileName.toLowerCase().contains('png')) {
      fileType = 'imagen';
    } else if (fileName.toLowerCase().contains('pdf')) {
      fileType = 'pdf';
    } else if (fileName.toLowerCase().contains('doc')) {
      fileType = 'word';
    } else if (fileName.toLowerCase().contains('docx')) {
      fileType = 'word';
    } else if (fileName.toLowerCase().contains('xls')) {
      fileType = 'excel';
    } else if (fileName.toLowerCase().contains('xlsx')) {
      fileType = 'excel';
    } else {
      'invalid';
    }
    return fileType;
  }

  uploadFileStorage(File file, String fileName, String type) {
    progressDialog.show();
    String idArchivo = FirebaseServices.databaseReference.push().key;
    FirebaseServices.storageReference
        .child('polizas')
        .child(globalControllerUsuario.usuario.uid)
        .child(idPoliza)
        .child('archivos')
        .child(idArchivo)
        .putFile(file)
        .then((snap) {
      snap.ref.getDownloadURL().then((url) {
        uploadFileDatabase(url, idArchivo, fileName, type);
      }).catchError((onError) {
        Future.delayed(Duration(milliseconds: 300)).then((value) {
          progressDialog.hide().whenComplete(() {
            UtilsDialog.alertDialogError(
                Get.overlayContext, Strings.errorUploadFile);
          });
        });
      });
    });
  }

  uploadFileDatabase(
      String url, String idArchivo, String fileName, String type) {
    Map value = {
      'nombre': fileName,
      'url': url,
      'tipo': type,
    };
    FirebaseServices.databaseReference
        .child('polizas')
        .child(globalControllerUsuario.usuario.uid)
        .child(idPoliza)
        .child('archivos')
        .child(idArchivo)
        .set(value)
        .then((value) {
      Future.delayed(Duration(milliseconds: 300)).then((value) {
        progressDialog.hide().whenComplete(() {
          UtilsDialog.alertDialogOneAction(
              Get.overlayContext,
              Strings.sArchivoCargado,
              Strings.sArchivoCargadoText,
              Strings.sAceptar,
              () => Get.back());
        });
      });
    });
  }
}
