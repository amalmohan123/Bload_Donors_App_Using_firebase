import 'package:bload_groups/helpers/colors.dart';
import 'package:bload_groups/helpers/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final formKey=GlobalKey<FormState>();

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
            fontWeight: ConstStyle.bold,
          ),
        ),
        backgroundColor: ConstColor.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: donorName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Donor's Name"),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter The Name";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: donorPhone,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Phone Number'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Number ";
                    } else if (value.length != 10) {
                      return 'Enter Currect Number';
                    } else {
                      return null;
                    }
                  },
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
                  validator: (value) {
                    if (value == null) {
                      return 'Select Blood Group';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                        content: Text('Edit Successful',),
                        duration: Duration(seconds: 2),
                        behavior:SnackBarBehavior.floating ,
                      ),
                    );
                    if(formKey.currentState!.validate()){
                    updateDonor(docId);
                    await Provider.of<DonorProvider>(context, listen: false)
                        .reloading();
                    Navigator.pop(context);

                    }
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(ConstColor.blueAccent),
                    minimumSize: MaterialStatePropertyAll(
                      Size(double.infinity, 45),
                    ),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                        color: ConstColor.whiteColor,
                        fontWeight: ConstStyle.bold,
                        fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
