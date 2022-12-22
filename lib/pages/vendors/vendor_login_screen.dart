import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';
import 'package:foodie_3/components/text_input_component.dart';
import 'package:foodie_3/constants/constant.dart';
import 'package:foodie_3/pages/vendors/vendor_change_password_screen.dart';
import 'package:foodie_3/pages/vendors/vendor_home_screen.dart';

class VendorLoginScreen extends StatefulWidget {
  const VendorLoginScreen({super.key});

  @override
  State<VendorLoginScreen> createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends State<VendorLoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool userNamevalidator = false;
  bool passwordValidator = false;
  VendorLogin vl = VendorLogin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text("Login"),
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
              "Welcome To Foodie",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text("Enter your username for sign in. Enjoy your business"),
            const SizedBox(
              height: 30,
            ),
            TextInputComponent(
              validator: userNamevalidator,
              validatorText: "Incorrect Username",
              obscureText: false,
              controller: usernameController,
              hintText: "Username",
            ),
            const SizedBox(
              height: 16,
            ),
            TextInputComponent(
              validator: passwordValidator,
              validatorText: "Incorrect Password",
              obscureText: true,
              controller: passwordController,
              hintText: "Password",
            ),
            const SizedBox(
              height: 16,
            ),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("Vendor").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ButtonComponent1(
                        buttonTitle: "Login",
                        buttonFunction: () {
                          if (usernameController.text.isEmpty) {
                            setState(() {
                              userNamevalidator = true;
                            });
                          } else if (passwordController.text.isEmpty) {
                            setState(() {
                              passwordValidator = true;
                            });
                          } else {
                            setState(() {
                              userNamevalidator = false;
                              passwordValidator = false;
                            });

                            for (int i = 0;
                                i < snapshot.data!.docs.length;
                                i++) {
                              if (snapshot.data!.docs[i]['username'] ==
                                      usernameController.text &&
                                  snapshot.data!.docs[i]['password'] ==
                                      passwordController.text &&
                                  snapshot.data!.docs[i]['is_first_time'] ==
                                      "1") {
                                //first time login change password
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VendorFirstTimeLogin(
                                              vendorUsername: snapshot
                                                  .data!.docs[i]['username'],
                                            )),
                                    (route) => false);
                                /**
                                 * fjhZ1qUQpibibXG
                                 * hgTowVEL
                                 */
                              } else if (snapshot.data!.docs[i]['username'] ==
                                      usernameController.text &&
                                  snapshot.data!.docs[i]['password'] ==
                                      passwordController.text &&
                                  snapshot.data!.docs[i]['is_first_time'] ==
                                      "2") {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VendorHomeScreen(
                                              vendorUsername: snapshot
                                                  .data!.docs[i]['username'],
                                            )),
                                    (route) => false);
                              } else {}
                            }
                          }
                        });
                  }
                  return const SizedBox();
                }),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                const SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 242, 184, 10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
                alignment: Alignment.center,
                child: const Text(
                  "Forgot password",
                  style: TextStyle(color: Colors.orange),
                )),
          ]),
        ),
      ),
    );
  }
}
