import 'package:cloud_firestore/cloud_firestore.dart';

class UserDoc {
  final String uid;
  final Map<String, dynamic> basiq;
  final Map<String, dynamic> charitySelection;
  final Map<String, dynamic> roundup;
  final List<dynamic> transactions;
  final String? firstName;
  final String? lastName;
  final Timestamp userCreated;

  UserDoc(this.uid, this.basiq, this.charitySelection, this.roundup,
      this.transactions, this.firstName, this.lastName, this.userCreated);

  factory UserDoc.fromDocSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserDoc(
      doc.id,
      data['basiq'] as Map<String, dynamic>,
      data['charitySelection'] as Map<String, dynamic>,
      data['roundup'] as Map<String, dynamic>,
      data['transactions'] as List<dynamic>,
      data['firstName'] as String?,
      data['lastName'] as String?,
      data['userCreated'] as Timestamp,
    );
  }
}

class TransactionDoc {
  final String id;
  final num amount;
  final String basiqTransactionId;
  final Map<String, num> charityPref;
  final Map<String, dynamic> givingPref;
  final Timestamp postDate;
  final String procDate;
  final String from;
  final String uid;

  TransactionDoc(
      this.id,
      this.amount,
      this.basiqTransactionId,
      this.charityPref,
      this.givingPref,
      this.postDate,
      this.procDate,
      this.from,
      this.uid);

  factory TransactionDoc.fromDocSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TransactionDoc(
      doc.id,
      data['amount'] as num,
      data['basiq_transaction_id'] as String,
      data['charityPref'] as Map<String, num>,
      data['givingPref'] as Map<String, dynamic>,
      data['post_date'] as Timestamp,
      data['proc_date'] as String,
      data['from'] as String,
      data['uid'] as String,
    );
  }
}
