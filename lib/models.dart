import 'package:cloud_firestore/cloud_firestore.dart';

class UserDoc {
  final String uid;
  final Map<String, dynamic> basiq;
  final Map<String, dynamic> charitySelection;
  final Map<String, dynamic> donationMethods;
  final String? firstName;
  final String? lastName;
  final String? email;
  final Timestamp userCreated;

  UserDoc(this.uid, this.basiq, this.charitySelection, this.donationMethods,
      this.firstName, this.lastName, this.email, this.userCreated);

  factory UserDoc.fromDocSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserDoc(
      doc.id,
      data['basiq'] as Map<String, dynamic>,
      data['charitySelection'] as Map<String, dynamic>,
      data['donationMethods'] as Map<String, dynamic>,
      data['firstName'] as String?,
      data['lastName'] as String?,
      data['email'] as String?,
      data['userCreated'] as Timestamp,
    );
  }
}

class BasiqTransactionDoc {
  final String id;
  final String accountId;
  final num amount;
  final String transactionClass;
  final String connectionId;
  final String description;
  final String direction;
  final String institutionId;
  final Timestamp? postDate;
  final String status;
  final Timestamp? transactionDate;
  final Map<String, dynamic> enrich;

  BasiqTransactionDoc(
      this.id,
      this.accountId,
      this.amount,
      this.transactionClass,
      this.connectionId,
      this.description,
      this.direction,
      this.institutionId,
      this.postDate,
      this.status,
      this.transactionDate,
      this.enrich);

  factory BasiqTransactionDoc.fromDocSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BasiqTransactionDoc(
        doc.id,
        data['accountId'] as String,
        data['amount'] as num,
        data['class'] as String,
        data['connection'] as String,
        data['description'] as String,
        data['direction'] as String,
        data['institutionId'] as String,
        data['postDate'] as Timestamp?,
        data['status'] as String,
        data['transactionDate'] as Timestamp?,
        data['enrich'] as Map<String, dynamic>);
  }
}

class OnyaTransactionDoc {
  final String id;
  final String basiqJobId;
  final Timestamp created;
  final Timestamp updated;
  final String status;
  final Map<String, dynamic> payer;
  final String description;
  final num amount;
  final List<dynamic> donationSources;

  OnyaTransactionDoc(
      this.id,
      this.basiqJobId,
      this.created,
      this.updated,
      this.status,
      this.payer,
      this.description,
      this.amount,
      this.donationSources);

  factory OnyaTransactionDoc.fromDocSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OnyaTransactionDoc(
        doc.id,
        data['basiqJobId'] as String,
        data['created'] as Timestamp,
        data['updated'] as Timestamp,
        data['status'] as String,
        data['payer'] as Map<String, dynamic>,
        data['description'] as String,
        data['amount'] as num,
        data['donationSources'] as List<dynamic>);
  }
}

class Charity {
  final String id;
  final String displayName;
  final String shortName;
  final String description;

  Charity(this.id, this.displayName, this.shortName, this.description);

  factory Charity.fromDocSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Charity(doc.id, data['displayName'] as String,
        data['shortName'] as String, data['description'] as String);
  }
}
