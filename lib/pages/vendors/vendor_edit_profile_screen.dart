import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/edit_textfield.dart';

class VendorEditProfileScreen extends StatefulWidget {
  final String vendorUsername;
  const VendorEditProfileScreen({super.key, required this.vendorUsername});

  @override
  State<VendorEditProfileScreen> createState() =>
      _VendorEditProfileScreenState();
}

class _VendorEditProfileScreenState extends State<VendorEditProfileScreen> {
  TextEditingController bioController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController openController = TextEditingController();
  TextEditingController closeController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool bioDone = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Vendor")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        if (snapshot.data!.docs[i]['username'] ==
                            widget.vendorUsername) {
                          return Column(
                            children: [
                              // EditTextField(
                              //   controller: usernameController,
                              //   editFunction: () {
                              //     snapshot.data!.docs[i].reference.update({
                              //       "username": usernameController.text,
                              //     });
                              //   },
                              //   hintText: snapshot.data!.docs[i]['username'],
                              //   label: 'Username',
                              // ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              EditTextField(
                                controller: bioController,
                                editFunction: () {
                                  snapshot.data!.docs[i].reference.update({
                                    "shop_bio": bioController.text,
                                  });
                                },
                                hintText: snapshot.data!.docs[i]['shop_bio'],
                                label: 'Bio',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              EditTextField(
                                controller: descriptionController,
                                editFunction: () {
                                  snapshot.data!.docs[i].reference.update({
                                    "shop_description":
                                        descriptionController.text,
                                  });
                                },
                                hintText: snapshot.data!.docs[i]
                                    ['shop_description'],
                                label: 'Description',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              EditTextField(
                                controller: openController,
                                editFunction: () {
                                  snapshot.data!.docs[i].reference.update({
                                    "open_hour": openController.text,
                                  });
                                },
                                hintText:
                                    snapshot.data!.docs[i]['open_hour'] == ""
                                        ? "Not stated"
                                        : snapshot.data!.docs[i]['open_hour'],
                                label: 'Open hour',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              EditTextField(
                                controller: closeController,
                                editFunction: () {
                                  snapshot.data!.docs[i].reference.update({
                                    "close_hour": closeController.text,
                                  });
                                },
                                hintText:
                                    snapshot.data!.docs[i]['close_hour'] == ""
                                        ? "Not stated"
                                        : snapshot.data!.docs[i]['close_hour'],
                                label: 'Close hour',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        }
                      }
                    }
                    return const SizedBox();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
