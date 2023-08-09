
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCollection{ 


 final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  List<DocumentSnapshot> _donorList = [];

  List<DocumentSnapshot> get donorList => _donorList;
  
}