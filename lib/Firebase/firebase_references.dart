import 'package:assurance/Firebase/firebase_services.dart';

class FirebaseReferences {
  static var dbRefAgentesSeguro =
      FirebaseServices.databaseReference.child('agentesSeguro');
  static var stRefAgentesSeguro =
      FirebaseServices.storageReference.child('agentesSeguro');
}
