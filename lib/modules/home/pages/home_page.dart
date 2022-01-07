import 'package:assurance/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('Menu principal\nComing Soon...'),
            ),
          );
        });
  }
}
