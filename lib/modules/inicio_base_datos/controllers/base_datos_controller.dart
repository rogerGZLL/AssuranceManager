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

  void readExcelSyncFusion() {}

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
      print('------------------');
      for (var row in excel.tables[table].rows) {
        print("$row");
      }*/
    }
    readSheet('GNP Autos');
    //readSheet('ANASEGUROS');
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
      String mes = '';
      String telefono = '';
      String correo = '';
      String poliza = '';
      String cobertura = '';
      Map auto = {};
      String vigenciaInicio = '';
      String vigenciaFin = '';
      String total = '';
      String formaPago = '';

      if (row[1] != null) {
        if (row[1].rowIndex > 3) {
          if (row[1].value.toString().isNotEmpty) {
            nombre = row[1].value.toString();
          }
        }
      }
      if (row[2] != null) {
        if (row[2].rowIndex > 3) {
          if (row[2].value.toString().isNotEmpty) {
            ejecutivo = row[2].value.toString();
          }
        }
      }
      if (row[3] != null) {
        if (row[3].rowIndex > 3) {
          if (row[3].value.toString().isNotEmpty) {
            rfc = row[3].value.toString();
          }
        }
      }
      if (row[4] != null) {
        if (row[4].rowIndex > 3) {
          if (row[4].value.toString().isNotEmpty) {
            fechaNacimiento = row[4].value.toString();
          }
        }
      }
      if (row[5] != null) {
        if (row[5].rowIndex > 3) {
          if (row[5].value.toString().isNotEmpty) {
            mes = row[5].value.toString();
          }
        }
      }
      if (row[6] != null) {
        if (row[6].rowIndex > 3) {
          if (row[6].value.toString().isNotEmpty) {
            telefono = row[6].value.toString();
          }
        }
      }
      if (row[7] != null) {
        if (row[7].rowIndex > 3) {
          if (row[7].value.toString().isNotEmpty) {
            correo = row[7].value.toString();
          }
        }
      }
      if (row[9] != null) {
        if (row[9].rowIndex > 3) {
          if (row[9].value.toString().isNotEmpty) {
            poliza = double.parse(row[9].value.toString()).toStringAsFixed(0);
            print(poliza);
          }
        }
      }
      if (row[9] != null) {
        if (row[9].rowIndex > 3) {
          if (row[9].value.toString().isNotEmpty) {
            poliza = row[9].value.toString();
          }
        }
      }
      if (row[11] != null) {
        if (row[11].rowIndex > 3) {
          if (row[11].value.toString().isNotEmpty) {
            cobertura = row[11].value.toString();
          }
        }
      }
      if (row[12] != null) {
        if (row[12].rowIndex > 3) {
          if (row[12].value.toString().isNotEmpty) {
            auto = {
              'adaptaciones': row[14]?.value.toString() == 'null'
                  ? ''
                  : row[14]?.value.toString(),
              'esLegalizado': '',
              'esResidente': '',
              'marca': row[12]?.value.toString() == 'null'
                  ? ''
                  : row[12]?.value.toString(),
              'modelo': row[15]?.value.toString() == 'null'
                  ? ''
                  : row[15]?.value.toString(),
              'motor': '',
              'placas': '',
              'serie': '',
              'tipo': row[13]?.value.toString() == 'null'
                  ? ''
                  : row[13]?.value.toString(),
            };
          }
        }
      }
      if (row[16] != null) {
        if (row[16].rowIndex > 3) {
          if (row[16].value.toString().isNotEmpty) {
            vigenciaInicio = row[16].value.toString();
          }
        }
      }
      if (row[17] != null) {
        if (row[17].rowIndex > 3) {
          if (row[17].value.toString().isNotEmpty) {
            vigenciaFin = row[17].value.toString();
          }
        }
      }
      if (row[19] != null) {
        if (row[19].rowIndex > 3) {
          if (row[19].value.toString().isNotEmpty) {
            formaPago = row[19].value.toString();
          }
        }
      }

      if (row[32] != null && nombre != null && ejecutivo != null) {
        if (row[32].rowIndex > 3) {
          if (row[32].value.toString().isNotEmpty) {
            total = row[32].value.toString();
          }
        }
      }
      if (nombre != null && ejecutivo != null) {
        dato = {
          'aseguradora': table,
          'clienteNombre': nombre,
          'ejecutivo': ejecutivo,
          'clienteRFC': rfc,
          'clienteFechaNacimiento': fechaNacimiento,
          'fechaPago': mes,
          'clienteTelefono': telefono,
          'clienteCorreo': correo,
          'numero': poliza,
          'cobertura': cobertura,
          'auto': auto,
          'fechaInicio': vigenciaInicio,
          'fechaTerminacion': vigenciaFin,
          'montoTotal': total,
          'formaPago': formaPago,
          'from': 'excel',
        };
        listMap.add(dato);
      }
    }

    listMap.forEach((dato) {
      String id = FirebaseServices.databaseReference.push().key;
      datosFirebase[id] = dato;
    });

    uploadPolizasFirebase(datosFirebase);
  }

  void uploadPolizasFirebase(Map<String, dynamic> data) {
    /*print(data);
    print('--------------');*/
    FirebaseServices.databaseReference
        .child('excelPolizas')
        .child(globalControllerUsuario.usuario.uid)
        .update(data);
  }
}
