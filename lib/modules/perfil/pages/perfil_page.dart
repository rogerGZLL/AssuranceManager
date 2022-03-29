import 'package:assurance/constants/theme_color.dart';
import 'package:assurance/modules/perfil/controllers/perfil_controller.dart';
import 'package:assurance/modules/perfil/pages/widgets/perfil_data.dart';
import 'package:assurance/modules/perfil/pages/widgets/perfil_title_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerfilController>(
        init: PerfilController(),
        builder: (_) {
          return Scaffold(
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [PerfilTitleImage(), PerfilData()],
            ),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: () => _.toEditProfile(),
                backgroundColor: ThemeColor.colorPrimary),
          );
        });
  }
}
