import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';
import 'package:foodie_3/pages/users/user_login_screen.dart';
import 'package:foodie_3/pages/users/user_wallet_screen.dart';

class UserProfileScreen extends StatefulWidget {
  final String username;
  const UserProfileScreen({super.key, required this.username});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset(
                "assets/user.png",
                width: 80,
                height: 80,
                color: Colors.amber,
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
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "My account",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
            child: Container(
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
                        builder: (context) => const UserLoginScreen()),
                    (route) => false);
              })
        ]),
      ),
    );
  }
}
