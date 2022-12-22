import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';

class VendorWalletScreen extends StatefulWidget {
  final String vendorUsername;
  const VendorWalletScreen({super.key, required this.vendorUsername});

  @override
  State<VendorWalletScreen> createState() => _VendorWalletScreenState();
}

class _VendorWalletScreenState extends State<VendorWalletScreen> {
  TextEditingController withdrawController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 150,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.amber,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Vendor Income",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text("Total Balance"),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("VendorWallet")
                            .snapshots(),
                        builder: (context, snapshot1) {
                          double vendorWalletDB =
                              0.0; //get all user's balance from vendorWallet
                          double withdrawDB =
                              0.0; //get all user's balance from withdraw
                          DateTime now = DateTime.now();
                          if (snapshot1.hasData) {
                            for (int i = 0;
                                i < snapshot1.data!.docs.length;
                                i++) {
                              if (snapshot1.data!.docs[i]['username'] ==
                                  widget.vendorUsername) {
                                vendorWalletDB += double.parse(
                                    snapshot1.data!.docs[i]['balance']);
                              }
                            }
                            return StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("Withdraw")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    for (int i = 0;
                                        i < snapshot.data!.docs.length;
                                        i++) {
                                      //check if user existed
                                      if (snapshot.data!.docs[i]['username'] ==
                                          widget.vendorUsername) {
                                        withdrawDB += double.parse(
                                            snapshot.data!.docs[i]['amount']);
                                      }
                                    }

                                    double balance =
                                        vendorWalletDB - withdrawDB;

                                    return Text(
                                      "RM ${balance.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    );
                                  }
                                  return const SizedBox();
                                });
                          }

                          return const SizedBox();
                        }),
                    // Text(
                    //   "RM 3,800.00",
                    //   style: TextStyle(
                    //       fontSize: 24,
                    //       fontWeight: FontWeight.w600,
                    //       color: Colors.white),
                    // ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "* Note that 20% commission deduction to Foodie",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Withdraw History",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                height: 340,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Withdraw")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data!.docs[index]['username'] ==
                                widget.vendorUsername) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                child: Row(children: [
                                  /**
                                           * transaction type
                                           * 1 - top up
                                           * 2 - withdrawal
                                           * 3 - foods
                                           */
                                  Image.asset(
                                    "assets/takeover.png",
                                    width: 35,
                                    height: 35,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text("Withdrawal"),
                                      Text(snapshot.data!.docs[index]['date']),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    "RM ${double.parse(snapshot.data!.docs[index]['amount']).toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                ]),
                              );
                            }
                            return const SizedBox();
                          });
                    }
                    return const SizedBox();
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonComponent1(
                buttonFunction: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            child: SizedBox(
                              width: 300,
                              height: 300,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/takeover.png",
                                    width: 100,
                                    height: 100,
                                    color: Colors.red,
                                  ),
                                  const Text(
                                    "Withdraw",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: const Color.fromARGB(
                                              255, 203, 203, 203)),
                                      child: TextField(
                                        decoration: const InputDecoration(
                                            hintText: "RM 10.00",
                                            border: InputBorder.none),
                                        controller: withdrawController,
                                      )),
                                  InkWell(
                                    onTap: () {
                                      //date function
                                      DateTime now = DateTime.now();

                                      //insert into transaction db
                                      FirebaseFirestore.instance
                                          .collection("VendorCommission")
                                          .add({});

                                      FirebaseFirestore.instance
                                          .collection("Withdraw")
                                          .add({
                                        "username": widget.vendorUsername,
                                        "amount": double.parse(
                                                withdrawController.text)
                                            .toStringAsFixed(2),
                                        "date":
                                            "${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}"
                                      }).then((value) =>
                                              Navigator.pop(context));
                                    },
                                    child: Container(
                                      width: 200,
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.amber),
                                      child: const Text(
                                        "Withdraw",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => VendorWithdrawAmount(
                  //               vendorUsername: widget.vendorUsername,
                  //             )));
                },
                buttonTitle: "Withdraw",
              ),
            ],
          ),
        ),
      )),
    );
  }
}
