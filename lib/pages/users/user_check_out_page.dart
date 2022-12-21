import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';
import 'package:foodie_3/pages/users/user_home_screen.dart';
import 'package:foodie_3/pages/users/user_wallet_screen.dart';

class UserCheckOutPage extends StatefulWidget {
  final String username;
  const UserCheckOutPage({super.key, required this.username});

  @override
  State<UserCheckOutPage> createState() => _UserCheckOutPageState();
}

class _UserCheckOutPageState extends State<UserCheckOutPage> {
  String isDineIn = "1";
  String isTakeAways = "0";
  TextEditingController pickUpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Cart").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              if (snapshot.data!.docs[i]['username'] == widget.username &&
                  snapshot.data!.docs[i]['cart_code'] == "1") {
                return Scaffold(
                    appBar: AppBar(),
                    body: Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 50,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Dine in options",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isDineIn = "1";
                                        isTakeAways = "0";
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              width: 2,
                                              color: isDineIn == "1"
                                                  ? Colors.amber
                                                  : Colors.black)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "Dine In",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                              "Enjoy your foods in our restaurant")
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isDineIn = "0";
                                        isTakeAways = "1";
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              width: 2,
                                              color: isTakeAways == "1"
                                                  ? Colors.amber
                                                  : Colors.black)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "Take Away",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                              "We will process your food before you reach")
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Pick up time:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Container(
                                          width: 100,
                                          height: 40,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: const Color.fromARGB(
                                                  255, 209, 209, 209)),
                                          child: TextField(
                                            controller: pickUpController,
                                            decoration: const InputDecoration(
                                                hintText: "12:00 am",
                                                border: InputBorder.none),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  const Text(
                                    "Order Summary",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("Cart")
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemBuilder: (context, index) {
                                                double totalAmount = 0;

                                                if (snapshot.data!.docs[index]
                                                            ['username'] ==
                                                        widget.username &&
                                                    snapshot.data!.docs[index]
                                                            ['cart_code'] ==
                                                        "1") {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 25,
                                                          height: 25,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: Text(
                                                            "${snapshot.data!.docs[index]['quantity']}x",
                                                            style: const TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 16,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['item_name'],
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            Text(snapshot.data!
                                                                    .docs[index]
                                                                ['choice'])
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        Text(snapshot.data!
                                                                .docs[index]
                                                            ['total_price']),
                                                      ],
                                                    ),
                                                  );
                                                }
                                                return const SizedBox();
                                              });
                                        }
                                        return const SizedBox();
                                      }),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Payment Details",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    alignment: Alignment.center,
                                    child: Row(children: [
                                      Image.asset(
                                        "assets/wallet.png",
                                        width: 25,
                                        height: 25,
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserWalletScreen(
                                                            username: widget
                                                                .username)));
                                          },
                                          child: const Text("Foodie wallet")),
                                      const Spacer(),
                                      const Text(
                                        ">",
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    alignment: Alignment.center,
                                    child: Row(children: [
                                      Image.asset(
                                        "assets/coupons.png",
                                        width: 25,
                                        height: 25,
                                        color: const Color.fromARGB(
                                            255, 207, 155, 1),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      const Text("Use Offers to get discounts"),
                                      const Spacer(),
                                      const Text(
                                        ">",
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ]),
                                  ),

                                  // Do not delete this
                                  const SizedBox(
                                    height: 160,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Cart")
                                .snapshots(),
                            builder: (context, snapshot) {
                              double totalAmount = 0;
                              if (snapshot.hasData) {
                                for (int i = 0;
                                    i < snapshot.data!.docs.length;
                                    i++) {
                                  if (snapshot.data!.docs[i]['username'] ==
                                          widget.username &&
                                      snapshot.data!.docs[i]['cart_code'] ==
                                          "1") {
                                    totalAmount += double.parse(
                                        snapshot.data!.docs[i]['total_price']);
                                  }
                                }

                                return Positioned(
                                  bottom: 0,
                                  child: Container(
                                    color: Colors.white,
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 16.0),
                                              child: Text(
                                                "Total",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                            const Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0),
                                              child: Text(
                                                "RM ${totalAmount.toStringAsFixed(2)}",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0, right: 16),
                                          child: ButtonComponent1(
                                              buttonTitle: "Place Order",
                                              buttonFunction: () {
                                                //generate a order number
                                                var randomNumber = Random();
                                                int orderNumber =
                                                    randomNumber.nextInt(1001);
                                                for (int i = 0;
                                                    i <
                                                        snapshot
                                                            .data!.docs.length;
                                                    i++) {
                                                  if (snapshot.data!.docs[i]
                                                              ['username'] ==
                                                          widget.username &&
                                                      snapshot.data!.docs[i]
                                                              ['cart_code'] ==
                                                          "1") {
                                                    snapshot
                                                        .data!.docs[i].reference
                                                        .update({
                                                      "order_number":
                                                          orderNumber
                                                              .toString(),
                                                      "cart_code": "2",
                                                      "dine_in_code": isDineIn,
                                                      "pick_up":
                                                          pickUpController.text,
                                                    });
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        UserHomeScreen(
                                                                          username:
                                                                              widget.username,
                                                                        )),
                                                            (route) => false);
                                                    print("success");
                                                  }
                                                }
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox();
                            }),
                      ],
                    ));
              }
            }
          }

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Text("No Order at the moment")],
              ),
            ),
          );
        });
  }
}
