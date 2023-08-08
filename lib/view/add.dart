import 'package:bload_groups/core/constance.dart';
import 'package:bload_groups/provider/home_page_prov.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  String? selectedGroups;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();
  Future addDonor()async {
    final add = {
      'name': donorName.text,
      'phone': donorPhone.text,
      'group': selectedGroups,
    };
    donor.add(add);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Donor',
          style: TextStyle(
            color: whiteColor,
            fontWeight: bold,
          ),
        ),
        backgroundColor: redColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                maxLength: 17,
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
                onPressed: ()async {
                await  addDonor();
                 await   Provider.of<DonorProvider>(context ,listen: false).reloading();
                  Navigator.pop(context);

                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(redColor),
                  minimumSize: MaterialStatePropertyAll(
                    Size(double.infinity, 45),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                      color: whiteColor, fontWeight: bold, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
