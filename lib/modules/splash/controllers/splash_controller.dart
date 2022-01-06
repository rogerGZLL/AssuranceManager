import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    // ignore: avoid_print
    Firebase.initializeApp().then((value) => print(value.options.asMap));
  }
}
