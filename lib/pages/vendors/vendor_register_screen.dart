import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';
import 'package:foodie_3/components/text_input_component.dart';
import 'package:foodie_3/pages/vendors/vendor_login_screen.dart';
import 'package:foodie_3/pages/vendors/waiting_approval_screen.dart';

class VendorRegisterScreen extends StatefulWidget {
  const VendorRegisterScreen({super.key});

  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopBioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController shopDescriptionController = TextEditingController();

  bool shopNameValidator = false;
  bool shopBiovalidator = false;
  bool shopDescValidator = false;
  bool phoneValidator = false;
  bool emailValidator = false;

  String mall = "";
  String location = "";
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
              validator: shopNameValidator,
              validatorText: "Incorrect Shop Name",
              obscureText: false,
              controller: shopNameController,
              hintText: "Shop Name",
            ),
            const SizedBox(
              height: 16,
            ),
            TextInputComponent(
              validator: shopBiovalidator,
              validatorText: "Incorrect Shop Bio",
              obscureText: false,
              controller: shopBioController,
              hintText: "Shop Bio",
            ),
            const SizedBox(
              height: 16,
            ),
            TextInputComponent(
              validator: shopDescValidator,
              validatorText: "Incorrect Shop Description",
              obscureText: false,
              controller: shopDescriptionController,
              hintText: "Shop Description",
            ),
            const SizedBox(
              height: 16,
            ),
            TextInputComponent(
              validator: phoneValidator,
              validatorText: "Incorrect Phone Number",
              obscureText: false,
              controller: phoneController,
              hintText: "Phone Number",
            ),
            const SizedBox(
              height: 16,
            ),
            TextInputComponent(
              validator: emailValidator,
              validatorText: "Incorrect Email",
              obscureText: false,
              controller: emailController,
              hintText: "ivan@gmail.com",
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text("Choose your location"),
                const SizedBox(
                  width: 16,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Location")
                        .snapshots(),
                    builder: (context, snapshot) {
                      String locationValue = "";
                      if (snapshot.hasData) {
                        return SizedBox(
                          child: DropdownButton(
                              hint: const Text("Location"),
                              items: snapshot.data!.docs.map((e) {
                                return DropdownMenuItem(
                                  value: e.data().values,
                                  child: Text(e.data().values.toString()),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  locationValue = value.toString();
                                  location = locationValue.replaceAll(
                                      RegExp(r'[^\w\s]+'), '');
                                  print(locationValue);
                                });
                              }),
                        );
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
                  "Location chosen: ",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  location,
                  style: const TextStyle(color: Colors.amber),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text("Choose your mall"),
                const SizedBox(
                  width: 16,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Mall")
                        .snapshots(),
                    builder: (context, snapshot) {
                      String mallValue = "";
                      if (snapshot.hasData) {
                        return DropdownButton(
                            hint: const Text("Mall"),
                            items: snapshot.data!.docs.map((e) {
                              return DropdownMenuItem(
                                value: e.data().values,
                                child: Text(e.data().values.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                mallValue = value.toString();
                                mall = mallValue.replaceAll(
                                    RegExp(r'[^\w\s]+'), '');
                                print(mall);
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
                  "Mall chosen: ",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  mall,
                  style: const TextStyle(color: Colors.amber),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
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
                  if (emailController.text.isEmpty) {
                    setState(() {
                      emailValidator = true;
                    });
                  } else if (phoneController.text.isEmpty) {
                    setState(() {
                      phoneValidator = true;
                    });
                  } else if (shopNameController.text.isEmpty) {
                    setState(() {
                      shopNameValidator = true;
                    });
                  } else if (shopBioController.text.isEmpty) {
                    setState(() {
                      shopBiovalidator = true;
                    });
                  } else if (shopDescriptionController.text.isEmpty) {
                    setState(() {
                      shopDescValidator = true;
                    });
                  } else {
                    setState(() {
                      shopBiovalidator = false;
                      shopNameValidator = false;
                      shopDescValidator = false;
                    });
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
                      "image": "",
                      "email": emailController.text,
                      "phone": phoneController.text,
                      "mall": mall,
                      "location": location,
                    }).then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ApprovalScreen()),
                          (route) => false);
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VendorLoginScreen()));
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
            ),
            const SizedBox(
              height: 100,
            ),
          ]),
        ),
      ),
    );
  }
}
