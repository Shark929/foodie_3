import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';
import 'package:foodie_3/pages/users/user_edit_profile.dart';
import 'package:foodie_3/pages/users/user_wallet_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../choose_register_role.dart';

class UserProfileScreen extends StatefulWidget {
  final String username;
  const UserProfileScreen({super.key, required this.username});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  //pick image function
  ImagePicker imagePicker = ImagePicker();
  XFile? file;
  String imageUrl = "";
  bool isLoading = false;
  bool canUpload = false;
  void pickImage() async {
    isLoading = true;
    file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
    // upload to firebase storage
    // get a reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('image');

    //create a reference for the image to be stored
    Reference referenceImageToUpload = referenceDirImages.child(uniqueName);

    //handle errors
    try {
      //Store the file
      await referenceImageToUpload.putFile(File(file!.path));

      imageUrl = await referenceImageToUpload.getDownloadURL();
      if (imageUrl != null) {
        setState(() {
          isLoading = false;
          canUpload = true;
        });
      }
      print(imageUrl);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Users").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    if (snapshot.data!.docs[i]['username'] == widget.username) {
                      return Row(
                        children: [
                          snapshot.data!.docs[i]['image'] == ""
                              ? Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        pickImage();
                                        snapshot.data!.docs[i].reference
                                            .update({
                                          "image": imageUrl,
                                        });
                                      },
                                      child: Image.asset(
                                        "assets/user.png",
                                        width: 80,
                                        height: 80,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text("Edit image")
                                  ],
                                )
                              : Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        pickImage();
                                        snapshot.data!.docs[i].reference
                                            .update({
                                          "image": imageUrl,
                                        });
                                      },
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data!.docs[i]['image']),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    const Text("Edit image"),
                                  ],
                                ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                widget.username,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                  }
                }
                return const SizedBox();
              }),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text(
                "My account",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserEditProfileScreen(
                              username: widget.username)));
                },
                child: const Text("Edit Profile   >"),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Users").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    if (snapshot.data!.docs[i]['username'] == widget.username) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.email),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                snapshot.data!.docs[i]['email'],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.phone),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                snapshot.data!.docs[i]['phone'],
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  }
                }
                return const SizedBox();
              }),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserWalletScreen(
                            username: widget.username,
                          )));
            },
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  Image.asset(
                    "assets/wallet.png",
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Text("Foodie wallet"),
                  const Spacer(),
                  const Text(
                    ">",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserWalletScreen(
                            username: widget.username,
                          )));
            },
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  Image.asset(
                    "assets/wallet.png",
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Text("Foodie wallet"),
                  const Spacer(),
                  const Text(
                    ">",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ButtonComponent1(
              buttonTitle: "Logout",
              buttonFunction: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChooseRegisterRolePage()),
                    (route) => false);
              })
        ]),
      ),
    );
  }
}
