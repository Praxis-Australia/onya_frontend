import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'dart:async';
import '../models.dart';

class DatabaseService {
  DatabaseService({required this.uid}) {
    _firestore = FirebaseFirestore.instance;
    _functions = FirebaseFunctions.instance;

    _functions.useFunctionsEmulator('localhost', 5001);
  }

  final String uid;
  late FirebaseFirestore _firestore;
  late FirebaseFunctions _functions;

  Future<UserDoc> getUser() async {
    final DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(uid).get();

    try {
      if (snapshot.exists) {
        return UserDoc.fromDocSnapshot(snapshot);
      } else {
        throw Exception('Firestore document for user does not exist');
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  Stream<UserDoc?> userStream() {
    return _firestore.collection('users').doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserDoc.fromDocSnapshot(snapshot);
      } else {
        return null;
      }
    });
  }

  Stream<TransactionDoc?> transactionStream(String id) {
    return _firestore
        .collection('transactions')
        .doc(id)
        .snapshots()
        .map((snapshot) {
      return TransactionDoc.fromDocSnapshot(snapshot);
    });
  }

  Future<void> completeRegistration(String? firstName, String? lastName) async {
    Map<String, dynamic> payload = {};
    if (firstName != null) payload['firstName'] = firstName;
    if (lastName != null) payload['lastName'] = lastName;

    await _firestore.collection('users').doc(uid).update(payload);
    try {
      await _functions.httpsCallable('createBasiqUser').call(payload);
    } on FirebaseFunctionsException catch (e) {
      print(e.code);
      print(e.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> updateRoundupConfig(
      String debitAccountId, String watchedAccountId, num roundTo) async {
    await _firestore.collection('users').doc(uid).update({
      'roundup.isConfigured': true,
      'roundup.config.debitAccountId': debitAccountId,
      'roundup.config.watchedAccountId': watchedAccountId,
      'roundup.config.roundTo': roundTo,
    });
  }

  Future<void> checkBasiqConnections() async {
    try {
      await _functions.httpsCallable('refreshUserBasicInfo').call();
    } on FirebaseFunctionsException catch (e) {
      print(e.code);
      print(e.message);
    } catch (e) {
      return Future.error(e);
    }
  }
}
