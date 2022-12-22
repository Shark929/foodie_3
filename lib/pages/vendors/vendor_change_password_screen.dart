import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';
import 'package:foodie_3/pages/vendors/vendor_home_screen.dart';

import '../../components/text_input_component.dart';

class VendorFirstTimeLogin extends StatefulWidget {
  final String vendorUsername;

  const VendorFirstTimeLogin({super.key, required this.vendorUsername});

  @override
  State<VendorFirstTimeLogin> createState() => _VendorFirstTimeLoginState();
}

class _VendorFirstTimeLoginState extends State<VendorFirstTimeLogin> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("First time login")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Set up new username and password",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputComponent(
                controller: usernameController,
                hintText: 'New username',
                obscureText: false,
                validator: false,
                validatorText: '',
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputComponent(
                controller: passwordController,
                hintText: 'New password',
                obscureText: true,
                validator: false,
                validatorText: '',
              ),
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
                          return ButtonComponent1(
                            buttonFunction: () {
                              snapshot.data!.docs[i].reference.update({
                                "username": usernameController.text,
                                "password": passwordController.text,
                                "is_first_time": "2",
                              }).then((value) => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VendorHomeScreen(
                                            vendorUsername:
                                                usernameController.text,
                                          )),
                                  (route) => false));
                            },
                            buttonTitle: 'Confirm',
                          );
                        }
                      }
                    }
                    return const SizedBox();
                  }),
            ],
          )),
        ),
      ),
    );
  }
}
