import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../servises/firebase/firebase.dart';


class DonorProvider extends ChangeNotifier {


  final FirebaseCollection firebaseCollection = FirebaseCollection();


  Future<List<DocumentSnapshot<Object?>>> fetchDonors() async {
    final snapshot = await firebaseCollection.donor.orderBy('name').get();
    firebaseCollection.bloodDonorList = snapshot.docs;
    return firebaseCollection.donorList;
  }


  Future<void> deleteDonor(String docId) async {
    await firebaseCollection.donor.doc(docId).delete();
    notifyListeners();
  }


  reloading() {
    notifyListeners();
  }
}
