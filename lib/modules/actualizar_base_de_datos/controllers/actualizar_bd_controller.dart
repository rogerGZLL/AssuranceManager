import 'dart:io';
import 'dart:js' as js;

import 'package:assurance/constants/strings.dart';
import 'package:assurance/Firebase/firebase_errors.dart';
import 'package:assurance/Firebase/firebase_services.dart';
import 'package:assurance/utils/utils.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:assurance/modules/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:excel/excel.dart';
import 'package:csv/csv.dart';
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
  List<File> files;
  List selectedFiles;
  File file;
  List polizas = [];
  List Aseguradoras;


  @override
  void onReady() {
    super.onReady();
    _progressDialog = UtilsDialog.showProgresDialog(
      Get.overlayContext,
      false,
    );
  }


  ////////////////////////////////////////////////////////////////////////////////////


  Future uploadFile() async{
    /*final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['xlsx']
    );*/
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if(result==null) return;
    final path = result.files.single.path;
    file = File(path);
    //files = result.files as List<File>;
  }


  void manageRowsColumns(){
    
  }


  void elegirPolizasNoActualizar(){

  }



  void openFile(int i){
    OpenFile.open(files[i].path);
  }


  void longPressFile(int i){
    selectedFiles.add(files[i]);
  }


  void cancelar(){
    Get.back();
  }


  ////////////////////////////////////////////////////////////////////////////////////


  void actualizar() {
    Map map;
    String smap = "{polizas: {";
    //var sfile = "Path_to_pre_existing_Excel_File/excel_file.xlsx";
    var bytes = File(file.path).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    List polizas = [];    // Obtener de firebase
    for (var table in excel.tables.keys) {    // table es la aseguradora en cuestión
      List<List<dynamic>> rows = excel.tables[table].rows;
      for(int i=0; i<excel.tables[table].rows.length; i++){
        smap += 'id: ' + polizas[0] + '{';    // Obtener el id de la póliza
        if(polizas[i][2] == 'Auto'){
            if(!rows[i][0].isEmpty) smap += 'numPoliza: ' + (rows[i][0] as String) + ', ';
            if(!rows[i][1].isEmpty) smap += 'ramo: ' + (rows[i][1] as String) + ', ';
            if(!rows[i][2].isEmpty) smap += 'aseguradora: ' + (rows[i][2] as String) + ', ';
            if(!rows[i][3].isEmpty) smap += 'cobertura: ' + (rows[i][3] as String) + ', ';
            if(!rows[i][4].isEmpty) smap += 'inciso: ' + (rows[i][4] as String) + ', ';
            if(!rows[i][5].isEmpty) smap += 'inciso: ' + (rows[i][5] as String) + ', ';
            if(!rows[i][6].isEmpty) smap += 'fechaInicio: ' + (rows[i][6] as String) + ', ';
            if(!rows[i][7].isEmpty) smap += 'fechaTerminacion: ' + (rows[i][7] as String) + ', ';
            if(!rows[i][8].isEmpty) smap += 'fechaEmision: ' + (rows[i][8] as String) + ', ';
            if(!rows[i][9].isEmpty) smap += 'fechaPago: ' + (rows[i][9] as String) + ', ';
            if(!rows[i][10].isEmpty) smap += 'estatus: ' + (rows[i][10] as String) + ', ';
            if(!rows[i][11].isEmpty) smap += 'montoTotal: ' + (rows[i][11] as String) + ', ';
            if(!rows[i][12].isEmpty) smap += 'cliente: ' + (rows[i][12] as String) + ', ';
            if(!rows[i][13].isEmpty) smap += 'marca: ' + (rows[i][13] as String) + ', ';
            if(!rows[i][14].isEmpty) smap += 'tipo: ' + (rows[i][14] as String) + ', ';
            if(!rows[i][15].isEmpty) smap += 'modelo: ' + (rows[i][15] as String) + ', ';
            if(!rows[i][16].isEmpty) smap += 'serie: ' + (rows[i][16] as String) + ', ';
            if(!rows[i][17].isEmpty) smap += 'motor: ' + (rows[i][17] as String) + ', ';
            if(!rows[i][18].isEmpty) smap += 'placas: ' + (rows[i][18] as String) + ', ';
            if(!rows[i][19].isEmpty) smap += 'residente: ' + (rows[i][19] as String) + ', ';
            if(!rows[i][20].isEmpty) smap += 'legalizado: ' + (rows[i][20] as String) + ', ';
            if(!rows[i][21].isEmpty) smap += 'adaptaciones: ' + (rows[i][21] as String) + '}';
        }
        else{
            if(!rows[i][0].isEmpty) smap += 'numPoliza: ' + (rows[i][0] as String) + ', ';
            if(!rows[i][1].isEmpty) smap += 'ramo: ' + (rows[i][1] as String) + ', ';
            if(!rows[i][2].isEmpty) smap += 'aseguradora: ' + (rows[i][2] as String) + ', ';
            if(!rows[i][3].isEmpty) smap += 'cobertura: ' + (rows[i][3] as String) + ', ';
            if(!rows[i][4].isEmpty) smap += 'inciso: ' + (rows[i][4] as String) + ', ';
            if(!rows[i][5].isEmpty) smap += 'inciso: ' + (rows[i][5] as String) + ', ';
            if(!rows[i][6].isEmpty) smap += 'fechaInicio: ' + (rows[i][6] as String) + ', ';
            if(!rows[i][7].isEmpty) smap += 'fechaTerminacion: ' + (rows[i][7] as String) + ', ';
            if(!rows[i][8].isEmpty) smap += 'fechaEmision: ' + (rows[i][8] as String) + ', ';
            if(!rows[i][9].isEmpty) smap += 'fechaPago: ' + (rows[i][9] as String) + ', ';
            if(!rows[i][10].isEmpty) smap += 'estatus: ' + (rows[i][10] as String) + ', ';
            if(!rows[i][11].isEmpty) smap += 'montoTotal: ' + (rows[i][11] as String) + ', ';
            if(!rows[i][12].isEmpty) smap += 'cliente: ' + (rows[i][12] as String) + '}';
        }
        if(i<rows.length-1) smap += '}, ';
        else smap += '}}';
      }
    }
    map = smap as Map;
    //firebaseRef.update(map);
  }
  
}