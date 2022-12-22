import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/edit_textfield.dart';

class UserEditProfileScreen extends StatefulWidget {
  final String username;
  const UserEditProfileScreen({super.key, required this.username});

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  TextEditingController bioController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController openController = TextEditingController();
  TextEditingController closeController = TextEditingController();

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
                      .collection("Users")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        if (snapshot.data!.docs[i]['username'] ==
                            widget.username) {
                          return Column(
                            children: [
                              EditTextField(
                                controller: bioController,
                                editFunction: () {
                                  snapshot.data!.docs[i].reference.update({
                                    "phone": bioController.text,
                                  });
                                },
                                hintText: snapshot.data!.docs[i]['phone'],
                                label: 'Phone',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              EditTextField(
                                controller: descriptionController,
                                editFunction: () {
                                  snapshot.data!.docs[i].reference.update({
                                    "email": descriptionController.text,
                                  });
                                },
                                hintText: snapshot.data!.docs[i]['email'],
                                label: 'Email',
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
