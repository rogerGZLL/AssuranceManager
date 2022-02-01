import 'package:assurance/constants/constants.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/inicio_polizas/controllers/archivos_controller.dart';
import 'package:assurance/modules/inicio_polizas/pages/polizas_widgets.dart/item_archivo_upload.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:assurance/widgets/widget_button_secondary.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:assurance/widgets/widget_text_secondary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgregarDocumentosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArchivosController>(
        init: ArchivosController(),
        builder: (_) {
          return Scaffold(
            appBar: WidgetAppBarMain(
                appBar: AppBar(),
                title: Strings.sAgregregarArchivos,
                isBack: true,
                back: () => Get.back()),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetTextSecondary(
                    text: Strings.sSeleccionaArchivo,
                    paddingHorizontal: 24,
                    paddingVertical: 0),
                WidgetMargin(margin: 24),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ItemArchivoUpload(
                              type: Strings.sGaleria,
                              path: Constants.icGallery,
                            ),
                            ItemArchivoUpload(
                                type: Strings.sPDF, path: Constants.icPdf),
                            ItemArchivoUpload(
                                type: Strings.sWord, path: Constants.icWord),
                            ItemArchivoUpload(
                                type: Strings.sExcel, path: Constants.icExcel),
                          ],
                        ),
                        WidgetButtonSecondary(
                            text: Strings.sSeleccionarArchivo,
                            fun: () {
                              _.selectFile();
                            })
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
