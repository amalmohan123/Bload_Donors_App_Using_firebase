import 'package:bload_groups/helpers/colors.dart';
import 'package:bload_groups/helpers/text_style.dart';
import 'package:bload_groups/provider/home_page_prov.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final formKey = GlobalKey<FormState>();

  Future addDonor() async {
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
            color: ConstColor.whiteColor,
            fontWeight: ConstStyle.bold,
          ),
        ),
        backgroundColor: ConstColor.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          // autovalidateMode: AutovalidateMode.always,
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  maxLength: 17,
                  controller: donorName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Donor's Name"),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter The Name';
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
                  maxLength: 10,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]'),
                    ),
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Phone Number'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Number';
                    } else if (value.length != 9) {
                      return 'Enter Correct Number';
                    }
                    return null;
                  },
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
                  validator: (value1) {
                    if (value1 == null) {
                      return "Select Blood Group";
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
                    if (formKey.currentState!.validate()) {
                      await addDonor();
                      await Provider.of<DonorProvider>(context, listen: false)
                          .reloading();
                      Navigator.pop(context);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 2),
                        backgroundColor: ConstColor.greenColor,
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          'Add Successfully ',
                          style: TextStyle(fontWeight: ConstStyle.bold),
                        ),
                      ),
                    );
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(ConstColor.blueAccent),
                    minimumSize: MaterialStatePropertyAll(
                      Size(double.infinity, 45),
                    ),
                  ),
                  child: const Text(
                    'Submit',
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
