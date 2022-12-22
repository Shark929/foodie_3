import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';
import 'package:foodie_3/components/text_input_component.dart';
import 'package:foodie_3/pages/vendors/vendor_home_screen.dart';
import 'package:image_picker/image_picker.dart';

class VendorAddMenu extends StatefulWidget {
  final String username;
  const VendorAddMenu({super.key, required this.username});

  @override
  State<VendorAddMenu> createState() => _VendorAddMenuState();
}

class _VendorAddMenuState extends State<VendorAddMenu> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemCodeController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  bool itemName = false;
  bool itemCode = false;
  bool itemDes = false;
  bool itemPrice = false;

  String categoryValue = "";
  String categoryResult = "";

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Menu"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                imageUrl.isNotEmpty
                    ? Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover)),
                      )
                    : InkWell(
                        onTap: pickImage,
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.add),
                              SizedBox(
                                height: 16,
                              ),
                              Text("Add a food picture")
                            ],
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                TextInputComponent(
                    controller: itemNameController,
                    hintText: "Item name",
                    obscureText: false,
                    validator: itemName,
                    validatorText: "Item name cannot be empty"),
                const SizedBox(
                  height: 20,
                ),
                TextInputComponent(
                    controller: itemCodeController,
                    hintText: "Item code",
                    obscureText: false,
                    validator: itemCode,
                    validatorText: "Item code cannot be empty"),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text("Choose your category"),
                    const SizedBox(
                      width: 16,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Category")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return DropdownButton(
                                hint: const Text("Category"),
                                items: snapshot.data!.docs.map((e) {
                                  return DropdownMenuItem(
                                    value: e.data().values,
                                    child: Text(e.data().values.toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    categoryValue = value.toString();
                                    categoryResult = categoryValue.replaceAll(
                                        RegExp(r'[^\w\s]+'), '');
                                    print(categoryResult);
                                  });
                                });
                          }
                          return const SizedBox();
                        }),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      "Category chosen: ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(categoryResult),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextInputComponent(
                    controller: itemDescriptionController,
                    hintText: "Item description",
                    obscureText: false,
                    validator: itemDes,
                    validatorText: "Description cannot be empty"),
                const SizedBox(
                  height: 20,
                ),
                TextInputComponent(
                    controller: itemPriceController,
                    hintText: "RM 0.00",
                    obscureText: false,
                    validator: itemPrice,
                    validatorText: "Price cannot be empty"),
                const SizedBox(
                  height: 30,
                ),
                ButtonComponent1(
                    buttonTitle: "Add",
                    buttonFunction: () {
                      if (itemNameController.text.isEmpty) {
                        setState(() {
                          itemName = true;
                        });
                      } else if (itemCodeController.text.isEmpty) {
                        setState(() {
                          itemCode = true;
                        });
                      } else if (itemDescriptionController.text.isEmpty) {
                        setState(() {
                          itemDes = true;
                        });
                      } else if (itemPriceController.text.isEmpty) {
                        setState(() {
                          itemPrice = true;
                        });
                      } else {
                        setState(() {
                          itemName = false;
                          itemCode = false;
                          itemDes = false;
                          itemPrice = false;
                        });
                        FirebaseFirestore.instance.collection("Menu").add({
                          "username": widget.username,
                          "item_name": itemNameController.text,
                          "item_code": itemCodeController.text,
                          "category": categoryResult,
                          "item_description": itemDescriptionController.text,
                          "price": itemPriceController.text,
                          "image": imageUrl,
                          "availablity": "1",
                        }).then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VendorHomeScreen(
                                    vendorUsername: widget.username))));
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
