import 'package:assurance/Firebase/firebase_services.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/login/pages/login_page.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:assurance/widgets/widget_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  List<Widget> _tabs = <Widget>[
    WidgetLoading(),
    WidgetLoading(),
  ];
  List<Widget> get tabs => _tabs;

  @override
  void onReady() {
    super.onReady();
  }

  void setIndex(int index) {
    if (index != 2) {
      _currentIndex = index;
    } else {
      UtilsDialog.alertDialogTwoActions(Get.overlayContext, Strings.signOut,
          Strings.signOutConfirm, Strings.sAceptar, Strings.sCancelar, () {
        Get.back();
        cerrarSesion();
      }, () {
        Get.back();
      });
    }
    update();
  }

  void cerrarSesion() {
    FirebaseServices.firebaseAuth
        .signOut()
        .then((value) => toWelcomePage())
        .catchError((onError) => UtilsDialog.alertDialogError(
            Get.overlayContext, Strings.signOutError));
  }

  void toWelcomePage() {
    Get.offAll(() => LoginPage());
  }
}
