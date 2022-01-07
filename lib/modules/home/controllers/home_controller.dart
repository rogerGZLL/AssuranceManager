import 'package:assurance/Firebase/firebase_services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    FirebaseServices.firebaseAuth.signOut();
  }
}
