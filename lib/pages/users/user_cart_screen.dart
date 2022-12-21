import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';
import 'package:foodie_3/components/tweak.dart';
import 'package:foodie_3/pages/users/user_check_out_page.dart';

class UserCartScreen extends StatefulWidget {
  final String username;
  const UserCartScreen({
    super.key,
    required this.username,
  });

  @override
  State<UserCartScreen> createState() => _UserCartScreenState();
}

class _UserCartScreenState extends State<UserCartScreen> {
  @override
  void initState() {
    super.initState();
  }

  String cartCode = "100"; // dummy cart code

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Cart").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              if (snapshot.data!.docs[i]['username'] == widget.username &&
                  snapshot.data!.docs[i]['cart_code'] == "1") {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Cart")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                //check if username is appeared in cart db or not
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: ((context, index) {
                                      if (snapshot.data!.docs[index]
                                                  ['username'] ==
                                              widget.username &&
                                          snapshot.data!.docs[index]
                                                  ['cart_code'] ==
                                              "1") {
                                        //add the total amount

                                        return SlideMenu(
                                            menuItems: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: IconButton(
                                                  color: Colors.red,
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  onPressed: () {
                                                    snapshot.data!.docs[index]
                                                        .reference
                                                        .delete();
                                                  },
                                                ),
                                              ),
                                            ],
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16.0),
                                              child: Row(children: [
                                                Container(
                                                  width: 120,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['image']),
                                                          fit: BoxFit.fill)),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                SizedBox(
                                                  height: 80,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['item_name'],
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16),
                                                      ),
                                                      Text(
                                                          "Quantity: ${snapshot.data!.docs[index]['quantity']}"),
                                                      Text(
                                                          "Choice: ${snapshot.data!.docs[index]['choice']}"),
                                                      // Text(
                                                      //     "RM ${snapshot.data!.docs[index]['price']}")
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "RM ${snapshot.data!.docs[index]['total_price']}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18),
                                                ),
                                              ]),
                                            ));
                                      }
                                      return const SizedBox();
                                    }));
                              }
                              return const Text("no cart at the now");
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        ButtonComponent1(
                            buttonTitle: "Checkout",
                            buttonFunction: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserCheckOutPage(
                                            username: widget.username,
                                          )));
                            })
                      ],
                    ),
                  ),
                );
              }
            }
          }

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("No Order at the moment")],
              ),
            ),
          );
        });
  }
}
