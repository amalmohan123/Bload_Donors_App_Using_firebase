import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonorProvider extends ChangeNotifier {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  List<DocumentSnapshot> _donorList = [];

  List<DocumentSnapshot> get donorList => _donorList;

  Future<List<DocumentSnapshot<Object?>>> fetchDonors() async {
    final snapshot = await donor.orderBy('name').get();
    _donorList = snapshot.docs;
    return donorList;
  
  }

  Future<void> deleteDonor(String docId) async {
    await donor.doc(docId).delete();
    notifyListeners();
  }
  reloading(){
    notifyListeners();
  }
}
