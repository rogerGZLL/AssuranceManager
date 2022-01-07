import 'package:assurance/constants/strings.dart';
import 'package:assurance/constants/theme_color.dart';
import 'package:assurance/widgets/widget_button_secondary.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:flutter/material.dart';

class UtilsDialog {
  static Future<void> alertDialogError(
      BuildContext context, String textError) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            clipBehavior: Clip.antiAlias,
            backgroundColor: ThemeColor.colorPrimary,
            contentPadding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            content: Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(24),
              color: ThemeColor.colorPrimary,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Strings.sError,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .apply(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const WidgetMargin(margin: 16),
                  Text(
                    textError,
                    style: const TextStyle(color: Colors.white54),
                    textAlign: TextAlign.center,
                  ),
                  const WidgetMargin(margin: 16),
                  WidgetButtonSecondary(
                      text: Strings.sAceptar, fun: () => Navigator.pop(context))
                ],
              ),
            ),
          );
        });
  }
}
