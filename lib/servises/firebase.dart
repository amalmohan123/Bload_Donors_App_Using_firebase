import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCollection {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  List<DocumentSnapshot> bloodDonorList = [];

  List<DocumentSnapshot> get donorList => bloodDonorList;
}
