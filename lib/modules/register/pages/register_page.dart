import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/register/controllers/register_controller.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (_) {
          return Scaffold(
            appBar: WidgetAppBarMain(
                appBar: AppBar(),
                title: Strings.sRegister,
                isBack: true,
                back: () => Get.back()),
          );
        });
  }
}
