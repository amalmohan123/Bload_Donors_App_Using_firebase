import 'package:bload_groups/core/constance.dart';
import 'package:bload_groups/project_1/add.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Bload Donation App',
            style: TextStyle(
              color: whiteColor,
              fontWeight: bold,
            ),
          ),
          backgroundColor: redColor,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (cxt) => AddUser(),
              ),
            );
          },
          backgroundColor: redColor,
          child: const Icon(
            Icons.add,
            color: whiteColor,
            size: 36,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
