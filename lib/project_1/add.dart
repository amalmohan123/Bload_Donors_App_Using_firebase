import 'package:bload_groups/core/constance.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final blodaGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  String? selectedGroups;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Donors',
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
            const Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Donor's Name"),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Phone Number'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                decoration:
                    const InputDecoration(label: Text('Select Bload Group')),
                items: blodaGroups
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
                onPressed: () {},
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
