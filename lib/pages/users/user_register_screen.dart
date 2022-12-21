import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';
import 'package:foodie_3/components/text_input_component.dart';
import 'package:foodie_3/pages/users/user_home_screen.dart';
import 'package:foodie_3/pages/users/user_login_screen.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool usernameValidator = false;
  bool passwordValidator = false;
  bool emailValidator = false;
  bool phoneValidator = false;

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
            const Text("Sign Up to get started. Start ordering your food."),
            const SizedBox(
              height: 30,
            ),
            TextInputComponent(
              validator: usernameValidator,
              validatorText: "Incorrect Username",
              obscureText: false,
              controller: usernameController,
              hintText: "ivan",
            ),
            const SizedBox(
              height: 16,
            ),
            TextInputComponent(
              validator: emailValidator,
              validatorText: "Incorrect Email",
              obscureText: false,
              controller: emailController,
              hintText: "ivanlim608@gmail.com",
            ),
            const SizedBox(
              height: 16,
            ),
            TextInputComponent(
              validator: phoneValidator,
              validatorText: "Incorrect Phone Number",
              obscureText: false,
              controller: phoneController,
              hintText: "01133869910",
            ),
            const SizedBox(
              height: 30,
            ),
            TextInputComponent(
              validator: passwordValidator,
              validatorText: "Incorrect Password",
              obscureText: true,
              controller: passwordController,
              hintText: "Password",
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
                  if (usernameController.text.isEmpty) {
                    setState(() {
                      usernameValidator = true;
                    });
                  } else if (emailController.text.isEmpty) {
                    setState(() {
                      emailValidator = true;
                    });
                  } else if (phoneController.text.isEmpty) {
                    setState(() {
                      phoneValidator = true;
                    });
                  } else if (passwordController.text.isEmpty) {
                    setState(() {
                      passwordValidator = true;
                    });
                  } else {
                    setState(() {
                      usernameValidator = false;
                      passwordValidator = false;
                      phoneValidator = false;
                      emailValidator = false;
                    });
                    FirebaseFirestore.instance
                        .collection("Users")
                        .doc(usernameController.text)
                        .set({
                      "username": usernameController.text,
                      "password": passwordController.text,
                      "image": "",
                      "email": emailController.text,
                      "phone": phoneController.text,
                    }).then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserHomeScreen(
                                    username: usernameController.text,
                                  )),
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
                            builder: (context) => const UserLoginScreen()));
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
