import 'package:assurance/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (_) {
          return Scaffold();
        });
  }
}
