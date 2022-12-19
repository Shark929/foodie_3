import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';
import 'package:foodie_3/components/text_input_component.dart';

class VendorRegisterScreen extends StatefulWidget {
  const VendorRegisterScreen({super.key});

  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopBioController = TextEditingController();
  TextEditingController shopDescriptionController = TextEditingController();
  bool textInputIsEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Create Account",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text("Sign Up to get started. Start generating your income"),
            const SizedBox(
              height: 30,
            ),
            TextInputComponent(
              controller: shopNameController,
              hintText: "Shop Name",
            ),
            const SizedBox(
              height: 16,
            ),
            TextInputComponent(
              controller: shopBioController,
              hintText: "Shop Bio",
            ),
            const SizedBox(
              height: 16,
            ),
            TextInputComponent(
              controller: shopDescriptionController,
              hintText: "Shop Description",
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonComponent1(
                buttonTitle: "Register",
                buttonFunction: () {
                  print("hello");
                  /**
                     * isOpen
                     * 1. "" = new vendor
                     * 2. "1" = open
                     * 3. "2" = close
                     */
                  if (shopNameController.text.isEmpty ||
                      shopBioController.text.isEmpty ||
                      shopDescriptionController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color.fromARGB(
                                          255, 238, 148, 141)),
                                  child: const Text(
                                    "Must enter all fields",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ));
                  } else {
                    FirebaseFirestore.instance
                        .collection("Vendor")
                        .doc(shopNameController.text)
                        .set({
                      "shop_name": shopNameController.text,
                      "shop_bio": shopBioController.text,
                      "shop_description": shopDescriptionController.text,
                      "username": "",
                      "password": "",
                      "operation_hours": "",
                      "isOpen": "",
                    });
                  }
                }),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                const SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection("Vendor")
                        .doc(shopNameController.text)
                        .set({
                      "shop_name": shopNameController.text,
                      "shop_bio": shopBioController.text,
                      "shop_description": shopDescriptionController.text,
                      "username": "",
                      "password": "",
                      "operation_hours": "",
                      "isOpen": "",
                    });
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 242, 184, 10),
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
