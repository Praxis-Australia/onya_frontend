import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'dart:async';
import '../models.dart';

class DatabaseService {
  DatabaseService({required this.uid}) {
    _firestore = FirebaseFirestore.instance;
    _functions = FirebaseFunctions.instanceFor(region: 'australia-southeast1');

    // _functions.useFunctionsEmulator('localhost', 5001);
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

// TODO : Implement explicitly cancelling stream when logging out
  Stream<UserDoc?> userStream() {
    return _firestore.collection('users').doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserDoc.fromDocSnapshot(snapshot);
      } else {
        return null;
      }
    });
  }

  Future<BasiqTransactionDoc?> getBasiqTransaction(String id) async {
    final DocumentSnapshot snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('basiqTransactions')
        .doc(id)
        .get();

    try {
      if (snapshot.exists) {
        return BasiqTransactionDoc.fromDocSnapshot(snapshot);
      } else {
        return null;
      }
    } catch (err) {
      print(err);
      return Future.error(err);
    }
  }

  Stream<Iterable<OnyaTransactionDoc>?> onyaTransactionsStream() {
    return _firestore
        .collection('onyaTransactions')
        .where('payer.userId', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      List<QueryDocumentSnapshot> docs = snapshot.docs;
      return docs.map((doc) => OnyaTransactionDoc.fromDocSnapshot(doc));
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

  Future<String> getClientToken() async {
    try {
      HttpsCallableResult res =
          await _functions.httpsCallable('getClientToken').call();
      return res.data['access_token'];
    } on FirebaseFunctionsException catch (e) {
      rethrow;
    } catch (e) {
      throw Future.error(e);
    }
  }

  Future<void> updateFromDonationCard(String charity, String method) async {
    // Add to a list in firestore under donationMethods.donationPreferences
    // the map {charity: charity, pledgeType: pledgeType}

    Map<String, dynamic> payload = {
      'donationMethods.donationPreferences': FieldValue.arrayUnion([
        {'charity': charity, 'method': method}
      ])
    };

    await _firestore.collection('users').doc(uid).update(payload);
  }

  // Future<void> removeDonationPreference(String charity, String method) async {
  //   // Add to a list in firestore under donationMethods.donationPreferences
  //   // the map {charity: charity, pledgeType: pledgeType}

  //   // Get the charity and method from the index

  //   Map<String, dynamic> payload = {
  //     'donationMethods.donationPreferences': FieldValue.arrayRemove(
  //         [{'charity': charity, 'method': method}]
  //     )
  //   };

  //   await _firestore.collection('users').doc(uid).update(payload);
  // }

  Future<void> updateRoundupConfig({bool? isEnabled, String? debitAccountId,
      String? watchedAccountId, num? roundTo}) async {

    Map<String, dynamic> payload = {};

    // If params are non-null, then add to payload
    if (isEnabled != null) {
      payload['donationMethods.roundup.isEnabled'] = isEnabled;
      if (isEnabled) {
        payload['roundup.nextDebit.lastChecked'] = Timestamp.now();
      }
    }

    if (debitAccountId != null) {
      payload['donationMethods.roundup.debitAccountId'] = debitAccountId;
    }

    if (watchedAccountId != null) {
      payload['donationMethods.roundup.watchedAccountId'] = watchedAccountId;
    }

    if (roundTo != null) {
      payload['donationMethods.roundup.roundTo'] = roundTo;
    }

    await _firestore.collection('users').doc(uid).update(payload);
  }

  Future<void> updateCharitySelection(Map<String, int> charitySelection) {
    // Check that each value is non-negative
    charitySelection.forEach((key, value) {
      if (value < 0) {
        throw Exception('Charity selection values must be non-negative');
      }
    });

    // Check that the sum of the values is 100
    int sum = charitySelection.values.reduce((a, b) => a + b);
    if (sum != 100) {
      throw Exception('Charity selection values must sum to 100');
    }

    Map<String, dynamic> payload = {
      'charitySelection': charitySelection,
    };

    return _firestore.collection('users').doc(uid).update(payload);
  }

  Future<void> checkBasiqConnections() async {
    try {
      await _functions.httpsCallable('refreshUserBasiqInfo').call();
    } on FirebaseFunctionsException catch (e) {
      rethrow;
    } catch (e) {
      throw Future.error(e);
    }
  }
}
