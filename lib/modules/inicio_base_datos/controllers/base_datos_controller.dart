import 'dart:io';

import 'package:assurance/Firebase/firebase_services.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/controllers/global_controller_usuario.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class BaseDatosController extends GetxController {
  GlobalControllerUsuario globalControllerUsuario =
      Get.find<GlobalControllerUsuario>();
  bool importando = false;
  Excel excel;

  void importarExcel() {
    if (!importando) {
      selectFile();
    } else {
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sImportandoError);
    }
  }

  Future<void> selectFile() async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xls', 'xlsx']);

    if (result != null) {
      File file = File(result.files.single.path);
      PlatformFile platformFile = result.files.single;
      if (platformFile.name.contains('xls') ||
          platformFile.name.contains('xlsx')) {
        /*print(file.path);
        print(file.lengthSync());
        print(platformFile.name);*/
        readExcel(file.path);
      } else {
        UtilsDialog.alertDialogError(
            Get.overlayContext, Strings.sErrorFormatFile);
      }
    }
  }

  void readExcel(String filePath) {
    var bytes = File(filePath).readAsBytesSync();
    excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      if (table.toString().trim().toLowerCase() != 'estado' &&
          table.toString().trim().toLowerCase() != 'resumen') {
        //print(table);
        //readSheet(table);
      }
      /*print('Table - ' + table); //sheet Name
      print('Max cols - ' + excel.tables[table].maxCols.toString());
      print('Max rows - ' + excel.tables[table].maxRows.toString());
      print('------------------');*/
      /* for (var row in excel.tables[table].rows) {
        print("$row");
      }*/
    }
    readSheet('GNP Autos');
  }

  void readSheet(String table) {
    var sheet = excel[table];
    print(sheet.maxCols);
    print(sheet.maxRows);
    List<Map> listMap = [];
    Map<String, dynamic> datosFirebase = Map();

    for (var row in sheet.rows) {
      Map dato = {};
      String nombre;
      String ejecutivo;
      String rfc = '';
      String fechaNacimiento = '';
      if (row[1] != null) {
        if (row[1].value.toString().isNotEmpty) {
          if (row[1].value.toString().toLowerCase().trim() != 'asegurado') {
            nombre = row[1].value.toString();
          }
        }
      }
      if (row[2] != null) {
        if (row[2].value.toString().isNotEmpty) {
          if (row[2].value.toString().toLowerCase().trim() != 'ejecutivo') {
            ejecutivo = row[2].value.toString();
          }
        }
      }
      if (row[3] != null) {
        if (row[3].value.toString().isNotEmpty) {
          if (row[3].value.toString().toLowerCase().trim() != 'r.f.c') {
            rfc = row[3].value.toString();
          }
        }
      }
      if (row[4] != null) {
        if (row[4].value.toString().isNotEmpty) {
          if (row[4].value.toString().toLowerCase().trim() !=
              'fecha nacimiento') {
            fechaNacimiento = row[4].value.toString();
          }
        }
      }
      if (nombre != null && ejecutivo != null) {
        dato = {
          'aseguradora': table,
          'nombre': nombre,
          'ejecutivo': ejecutivo,
          'rfc': rfc,
          'fechaNacimiento': fechaNacimiento,
        };
        listMap.add(dato);
      }
    }

    listMap.forEach((dato) {
      String id = FirebaseServices.databaseReference.push().key;
      datosFirebase[id] = dato;
    });

    uploadDataFirebase(datosFirebase);
  }

  void uploadDataFirebase(Map<String, dynamic> data) {
    print(data);
    print('--------------');
    FirebaseServices.databaseReference
        .child('excelDatabase')
        .child(globalControllerUsuario.usuario.uid)
        .update(data);
  }
}
