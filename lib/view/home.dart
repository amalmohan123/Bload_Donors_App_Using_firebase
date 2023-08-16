import 'dart:async';

import 'package:bload_groups/provider/home_page_prov.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import '../helpers/colors.dart';
import '../helpers/text_style.dart';

import 'add.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  late StreamSubscription subscription;

  var isDeviceConnected = false;

  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    getConnectivity();
  }

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;

      if (!isDeviceConnected && isAlertSet == false) {
        showDialogBox();
        setState(() {
          isAlertSet = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  showDialogBox() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("No Connection"),
        content: const Text("Please check your internet connectivity"),
        actions: <Widget>[
          TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() {
                  isAlertSet = false;
                });
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox();
                  setState(() {
                    isAlertSet = true;
                  });
                }
              },
              child: const Text('OK'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blood Donation App',
          style: TextStyle(
            color: ConstColor.whiteColor,
            fontWeight: ConstStyle.bold,
          ),
        ),
        backgroundColor: ConstColor.blueAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (cxt) => const AddUser(),
            ),
          );
        },
        backgroundColor: ConstColor.blueAccent,
        child: const Icon(
          Icons.add,
          color: ConstColor.whiteColor,
          size: 36,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Consumer<DonorProvider>(
        builder: (context, donorProvider, _) {
          return FutureBuilder(
            future: donorProvider.fetchDonors(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Consumer<DonorProvider>(
                builder: (context, value, child) => ListView.builder(
                  itemCount: donorProvider.firebaseCollection.donorList.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot donorSnap =
                        donorProvider.firebaseCollection.donorList[index];
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: ConstColor.lightBlue,
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(66, 72, 69, 69),
                                blurRadius: 10,
                                spreadRadius: 8),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: ConstColor.blueAccent,
                                  radius: 32,
                                  child: Text(
                                    donorSnap['group'],
                                    style: const TextStyle(
                                      fontWeight: ConstStyle.bold,
                                      fontSize: 25,
                                      color: ConstColor.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  donorSnap['name'],
                                  style: const TextStyle(
                                    fontWeight: ConstStyle.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  donorSnap['phone'].toString(),
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/update',
                                      arguments: {
                                        'name': donorSnap['name'],
                                        'phone': donorSnap['phone'].toString(),
                                        'group': donorSnap['group'],
                                        'id': donorSnap.id,
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                  color: ConstColor.blueColor,
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Delete Item'),
                                          content: const Text(
                                              'Do you want to delete this item ?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                donorProvider
                                                    .deleteDonor(donorSnap.id);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Delete'),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.delete),
                                  color: ConstColor.redColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
