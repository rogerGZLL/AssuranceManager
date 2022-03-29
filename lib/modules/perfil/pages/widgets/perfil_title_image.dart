import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/perfil/controllers/perfil_controller.dart';
import 'package:assurance/widgets/widget_image.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class PerfilTitleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerfilController>(builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Card(
              elevation: 12.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: _.selectImage,
                child: WidgetImage(
                    height: 80,
                    width: 80,
                    boxFit: BoxFit.cover,
                    url: _.globalControllerUsuario.usuario.avatar),
              ),
            ),
            const WidgetMargin(margin: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.appTitle,
                  style: Theme.of(context).textTheme.headline6,
                ),
                WidgetMargin(margin: 2),
                Text(
                  _.globalControllerUsuario.usuario.nombre,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .apply(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
