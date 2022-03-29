import 'package:assurance/modules/perfil/controllers/perfil_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ItemPerfilPreference extends StatelessWidget {
  final String title;
  final bool enable;
  final String type;

  const ItemPerfilPreference(
      {Key key,
      @required this.title,
      @required this.enable,
      @required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerfilController>(builder: (_) {
      return Card(
        margin: EdgeInsets.all(0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        color: Colors.blueGrey.shade50,
        elevation: 1.0,
        child: SwitchListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          isThreeLine: false,
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          value: enable,
          onChanged: (value) {
            _.updatePreference(type, value);
          },
        ),
      );
    });
  }
}
