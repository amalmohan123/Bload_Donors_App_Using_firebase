import 'package:bload_groups/core/constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/home_page_prov.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  String? selectedGroups;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();

  void updateDonor(docid) {
    final data = {
      'name': donorName.text,
      'phone': donorPhone.text,
      'group': selectedGroups
    };
    donor.doc(docid).update(data);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = args['name'];
    donorPhone.text = args['phone'];
    selectedGroups = args['group'];
    final docId = args['id'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Details',
          style: TextStyle(
            color: ConstColor.whiteColor,
            fontWeight:ConstStyle.bold,
          ),
        ),
        backgroundColor: ConstColor.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: donorName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Donor's Name"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: donorPhone,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Phone Number'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                value: selectedGroups,
                decoration: const InputDecoration(
                  label: Text('Select Blood Group'),
                ),
                items: bloodGroups
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  selectedGroups = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  updateDonor(docId);
                  await Provider.of<DonorProvider>(context, listen: false)
                      .reloading();
                  Navigator.pop(context);
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(ConstColor.blueAccent),
                  minimumSize: MaterialStatePropertyAll(
                    Size(double.infinity, 45),
                  ),
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(
                      color:ConstColor.whiteColor , fontWeight: ConstStyle.bold, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
