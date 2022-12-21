import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';
import 'package:foodie_3/pages/choose_register_role.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VendorProfileScreen extends StatefulWidget {
  final String vendorUsername;
  const VendorProfileScreen({super.key, required this.vendorUsername});

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
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
        child: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Vendor").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            if (snapshot.data!.docs[i]['username'] == widget.vendorUsername) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 200,
                      color: Colors.amber[100],
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          snapshot.data!.docs[i]['image'] == ""
                              ? Stack(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/user.png"))),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        pickImage();
                                      },
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle),
                                        child: const Icon(Icons.add),
                                      ),
                                    )
                                  ],
                                )
                              : Stack(children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(imageUrl != ""
                                                ? imageUrl
                                                : snapshot.data!.docs[i]
                                                    ['image']),
                                            fit: BoxFit.cover)),
                                  ),
                                  imageUrl == ""
                                      ? const SizedBox()
                                      : InkWell(
                                          onTap: () {
                                            snapshot.data!.docs[i].reference
                                                .update({
                                              "image": imageUrl,
                                            });
                                            setState(() {
                                              imageUrl = "";
                                            });
                                          },
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                                color: Colors.grey,
                                                shape: BoxShape.circle),
                                            child: const Icon(Icons.check),
                                          ),
                                        )
                                ]),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            snapshot.data!.docs[i]['username'],
                            style: const TextStyle(fontSize: 24),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bio",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(snapshot.data!.docs[i]['shop_bio'])
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(snapshot.data!.docs[i]['shop_description'])
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ButtonComponent1(
                        buttonTitle: "Logout",
                        buttonFunction: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChooseRegisterRolePage()),
                              (route) => false);
                        }),
                  )
                ],
              );
            }
          }
        }
        return const SizedBox();
      },
    ));
  }
}
