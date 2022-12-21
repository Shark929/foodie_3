import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';
import 'package:foodie_3/components/text_input_component.dart';
import 'package:foodie_3/constants/constant.dart';
import 'package:foodie_3/pages/users/user_home_screen.dart';
import 'package:foodie_3/pages/users/user_register_screen.dart';
import 'package:foodie_3/pages/vendors/vendor_home_screen.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool userNamevalidator = false;
  bool passwordValidator = false;
  VendorLogin vl = VendorLogin();

  @override
  void initState() {
    super.initState();
    
  }

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
            const Text("Enter your username for sign in. Order your food now"),
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
                    FirebaseFirestore.instance.collection("Users").snapshots(),
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
                                      passwordController.text) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserHomeScreen(
                                              username: snapshot.data!.docs[i]
                                                  ['username'],
                                            )),
                                    (route) => false);
                              } else if (snapshot.data!.docs[i]['username'] !=
                                      usernameController.text ||
                                  snapshot.data!.docs[i]['password'] !=
                                      passwordController.text) {
                                //ZKZJQOUYcidd96b
                                //dSfzIapI
                                return showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                          child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 50,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: const Color.fromARGB(
                                                      255, 238, 148, 141)),
                                              child: const Text(
                                                "Incorrect username or password",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                        ));
                              }
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
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserRegisterScreen()),
                        (route) => false);
                  },
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
