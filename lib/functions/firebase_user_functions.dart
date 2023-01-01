import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFunction {
  static Future<Map<String, dynamic>?> read(String collection, String document) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final snapshot = await firestore.collection(collection).doc(document).get();
    return snapshot.data();
  }
}