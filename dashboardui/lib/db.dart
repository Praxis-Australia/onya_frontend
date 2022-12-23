import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'models.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();

  Stream<UserDoc?> userStream(String uid) {
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
}

class UserChangeNotifier extends ChangeNotifier {
  UserChangeNotifier() {
    _authChangesSubscription = _db.authChanges.listen((user) {
      _user = user;
      notifyListeners();
    });

    if (_user != null) {
      _userChangesSubscription = _db.userStream(_user!.uid).listen((user) {
        notifyListeners();
      });
    }
  }

  final DatabaseService _db = DatabaseService();
  late final StreamSubscription<User?> _authChangesSubscription;
  late final StreamSubscription<UserDoc?> _userChangesSubscription;
  User? _user;

  User? get user => _user;

  @override
  void dispose() {
    _authChangesSubscription.cancel();
    _userChangesSubscription.cancel();
    super.dispose();
  }
}
