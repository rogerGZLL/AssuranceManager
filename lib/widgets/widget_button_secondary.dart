import 'package:assurance/constants/theme_color.dart';
import 'package:flutter/material.dart';

class WidgetButtonSecondary extends StatelessWidget {
  final String text;
  final Function fun;
  WidgetButtonSecondary({@required this.text, @required this.fun});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        onPressed: fun,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        textColor: ThemeColor.colorSecondary,
        child: Text(
          text,
          textAlign: TextAlign.end,
        ));
  }
}
