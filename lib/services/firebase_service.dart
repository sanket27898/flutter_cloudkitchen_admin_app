import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  Future<DocumentSnapshot> getAdminCredentials(id) {
    var result = FirebaseFirestore.instance.collection('Admin').doc(id).get();
    return result;
  }
}
