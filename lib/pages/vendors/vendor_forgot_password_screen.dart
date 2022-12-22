import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';
import 'package:foodie_3/components/text_input_component.dart';
import 'package:foodie_3/pages/vendors/vendor_login_screen.dart';

class VendorForgotPassword extends StatefulWidget {
  const VendorForgotPassword({super.key});

  @override
  State<VendorForgotPassword> createState() => _VendorForgotPasswordState();
}

class _VendorForgotPasswordState extends State<VendorForgotPassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool vendorIsExisted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Forgot Password",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            vendorIsExisted
                ? TextInputComponent(
                    controller: passwordController,
                    hintText: "Enter your new password",
                    obscureText: true,
                    validator: false,
                    validatorText: "",
                  )
                : TextInputComponent(
                    controller: emailController,
                    hintText: "Enter your email",
                    obscureText: false,
                    validator: false,
                    validatorText: "",
                  ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Vendor").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    if (snapshot.data!.docs[i]['email'] ==
                        emailController.text) {
                      return ButtonComponent1(
                        buttonTitle: "Enter",
                        buttonFunction: () {
                          setState(() {
                            vendorIsExisted = true;
                          });
                        },
                      );
                    }
                  }
                }
                return const SizedBox();
              },
            ),
            vendorIsExisted == true
                ? StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Vendor")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          if (snapshot.data!.docs[i]['email'] ==
                              emailController.text) {
                            return ButtonComponent1(
                              buttonTitle: "Confirm",
                              buttonFunction: () {
                                snapshot.data!.docs[i].reference.update({
                                  "password": passwordController.text,
                                }).then((value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const VendorLoginScreen()),
                                    (route) => false));
                              },
                            );
                          }
                        }
                      }
                      return const SizedBox();
                    },
                  )
                : const SizedBox(),
          ],
        ),
      )),
    );
  }
}
