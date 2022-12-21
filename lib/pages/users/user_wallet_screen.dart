import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';

class UserWalletScreen extends StatefulWidget {
  final String username;
  const UserWalletScreen({super.key, required this.username});

  @override
  State<UserWalletScreen> createState() => _UserWalletScreenState();
}

class _UserWalletScreenState extends State<UserWalletScreen> {
  TextEditingController topupController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Foodie Wallet"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Wallet").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              if (snapshot.data!.docs[i]['username'] == widget.username) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Balance"),
                          Row(
                            children: [
                              const Text("RM"),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                snapshot.data!.docs[i]['balance'],
                                style: const TextStyle(
                                    fontSize: 36, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                            child: SizedBox(
                                              width: 300,
                                              height: 300,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    "assets/top-up.png",
                                                    width: 100,
                                                    height: 100,
                                                    color: Colors.green,
                                                  ),
                                                  const Text(
                                                    "Top Up",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20),
                                                      width: 200,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              203, 203, 203)),
                                                      child: TextField(
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText:
                                                                    "RM 10.00",
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                        controller:
                                                            topupController,
                                                      )),
                                                  InkWell(
                                                    onTap: () {
                                                      //update wallet
                                                      double newBalance = double
                                                              .parse(snapshot
                                                                      .data!
                                                                      .docs[i]
                                                                  ['balance']) +
                                                          double.parse(
                                                              topupController
                                                                  .text);

                                                      snapshot.data!.docs[i]
                                                          .reference
                                                          .update({
                                                        "balance": newBalance
                                                            .toStringAsFixed(2),
                                                      });

                                                      //date function
                                                      DateTime now =
                                                          DateTime.now();

                                                      //insert into transaction db

                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              "Transactions")
                                                          .add({
                                                        "username":
                                                            widget.username,
                                                        "amount": double.parse(
                                                                topupController
                                                                    .text)
                                                            .toStringAsFixed(2),
                                                        "type": "1",
                                                        "date":
                                                            "${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}"
                                                      }).then((value) =>
                                                              Navigator.pop(
                                                                  context));
                                                    },
                                                    child: Container(
                                                      width: 200,
                                                      height: 50,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: Colors.amber),
                                                      child: const Text(
                                                        "Top Up",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(color: Colors.black)),
                                  child: const Text(
                                    "+",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Transactions",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("Transactions")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        if (snapshot.data!.docs[index]
                                                ['username'] ==
                                            widget.username) {
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 16),
                                            child: Row(children: [
                                              /**
                                           * transaction type
                                           * 1 - top up
                                           * 2 - withdrawal
                                           * 3 - foods
                                           */
                                              snapshot.data!.docs[index]
                                                          ['type'] ==
                                                      "1"
                                                  ? Image.asset(
                                                      "assets/top-up.png",
                                                      width: 35,
                                                      height: 35,
                                                      color: Colors.green,
                                                    )
                                                  : snapshot.data!.docs[index]
                                                              ['type'] ==
                                                          "2"
                                                      ? Image.asset(
                                                          "assets/takeover.png",
                                                          width: 35,
                                                          height: 35,
                                                          color: Colors.red,
                                                        )
                                                      : Image.asset(
                                                          "assets/dish.png",
                                                          width: 35,
                                                          height: 35,
                                                          color: Colors.amber,
                                                        ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(snapshot.data!
                                                                  .docs[index]
                                                              ['type'] ==
                                                          "1"
                                                      ? "Top Up"
                                                      : snapshot.data!.docs[
                                                                      index]
                                                                  ['type'] ==
                                                              "2"
                                                          ? "Withdrawal"
                                                          : "Foods"),
                                                  Text(snapshot.data!
                                                      .docs[index]['date']),
                                                ],
                                              ),
                                              const Spacer(),
                                              Text(
                                                "RM ${double.parse(snapshot.data!.docs[index]['amount']).toStringAsFixed(2)}",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ]),
                                          );
                                        }
                                        return const SizedBox();
                                      });
                                }
                                return const SizedBox();
                              })
                        ],
                      )
                    ],
                  ),
                );
              } else if (snapshot.data!.docs[i]['username'] !=
                  widget.username) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: ButtonComponent1(
                      buttonFunction: () {
                        FirebaseFirestore.instance
                            .collection("Wallet")
                            .doc()
                            .set({
                          "username": widget.username,
                          "balance": "0",
                        });
                      },
                      buttonTitle: "Create Foodie Wallet",
                    ),
                  ),
                );
              }
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
