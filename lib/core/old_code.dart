// import 'package:bload_groups/core/constance.dart';
// import 'package:bload_groups/view/add.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';



// class HomePage extends StatelessWidget {
//   HomePage({super.key});

//   final CollectionReference donor =
//       FirebaseFirestore.instance.collection('donor');

//   void deleteDonor(docId) {
//     donor.doc(docId).delete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Blood Donation App',
//             style: TextStyle(
//               color: whiteColor,
//               fontWeight: bold,
//             ),
//           ),
//           backgroundColor: redColor,
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (cxt) => const AddUser(),
//               ),
//             );
//           },
//           backgroundColor: redColor,
//           child: const Icon(
//             Icons.add,
//             color: whiteColor,
//             size: 36,
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         body: StreamBuilder(
//           stream: donor.orderBy('name').snapshots(),
//           builder: (context, AsyncSnapshot snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data.docs.length,
//                 itemBuilder: (context, index) {
//                   final DocumentSnapshot donorSnap = snapshot.data.docs[index];
//                   return Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Container(
//                       height: 80,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           color: whiteColor,
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: Color.fromARGB(66, 72, 69, 69),
//                                 blurRadius: 10,
//                                 spreadRadius: 8)
//                           ]),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: CircleAvatar(
//                                 backgroundColor: redColor,
//                                 radius: 32,
//                                 child: Text(
//                                   donorSnap['group'],
//                                   style: const TextStyle(
//                                     fontWeight: bold,
//                                     fontSize: 25,
//                                     color: whiteColor,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                                                     Text(
//                                 donorSnap['name'],
//                                 style: const TextStyle(
//                                   fontWeight: bold,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                               Text(
//                                 donorSnap['phone'].toString(),
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   Navigator.pushNamed(context, '/update',
//                                       arguments: {
//                                         'name': donorSnap['name'],
//                                         'phone': donorSnap['phone'].toString(),
//                                         'group': donorSnap['group'],
//                                         'id': donorSnap.id,
//                                       });
//                                 },
//                                 icon: const Icon(Icons.edit),
//                                 color: blueColor,
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   deleteDonor(donorSnap.id);
//                                 },
//                                 icon: const Icon(Icons.delete),
//                                 color: redColor,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }
