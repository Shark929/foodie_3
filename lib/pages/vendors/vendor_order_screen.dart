import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/pages/conversation_screen.dart';

class VendorOrderScreen extends StatefulWidget {
  final String vendorUsername;
  const VendorOrderScreen({super.key, required this.vendorUsername});

  @override
  State<VendorOrderScreen> createState() => _VendorOrderScreenState();
}

/**
 * vendor order code
 * 0. user cancel order
 * 1. user add to cart
 * 2. user paid 
 * 3. vendor accept order
 * 4. vendor prepare order
 * 5. vendor completed order
 * 6. vendor cancel order
 */
class _VendorOrderScreenState extends State<VendorOrderScreen> {
  bool isAccepted = false;
  bool isCompleted = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Cart").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data!.docs[index]['vendor'] ==
                                widget.vendorUsername &&
                            (snapshot.data!.docs[index]['cart_code'] != "1" &&
                                snapshot.data!.docs[index]['cart_code'] !=
                                    "0" &&
                                snapshot.data!.docs[index]['cart_code'] !=
                                    "6")) {
                          return Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.amber, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]
                                              ['item_name'],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(snapshot.data!.docs[index]
                                            ['choice']),
                                        Text(
                                            "x${snapshot.data!.docs[index]['quantity'].toString()}"),
                                        Text(
                                            "RM ${snapshot.data!.docs[index]['price']}"),
                                      ],
                                    ),
                                    const Spacer(),
                                    snapshot.data!.docs[index]['cart_code'] ==
                                            "2"
                                        ? Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  /**
                                                   * if Accepted == true,
                                                   * then button will be changed
                                                   */

                                                  setState(() {
                                                    isAccepted = true;
                                                  });

                                                  /**
                                                   * here is the vendor accept order button
                                                   * cart_code should be updated from 3 to 3
                                                   */

                                                  snapshot.data!.docs[index]
                                                      .reference
                                                      .update({
                                                    "cart_code": "3",
                                                  });

                                                  /**
                                                   * Once order accepted by vendor,
                                                   * total_price will be added into vendorwallet database
                                                   */

                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          "VendorWallet")
                                                      .add({
                                                    "username":
                                                        widget.vendorUsername,
                                                    "balance": snapshot
                                                            .data!.docs[index]
                                                        ['total_price'],
                                                  });
                                                  print("done");
                                                },
                                                child: Container(
                                                  width: 60,
                                                  height: 30,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: const Text("Accept"),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection("Wallet")
                                                      .snapshots(),
                                                  builder:
                                                      (context, snapshot11) {
                                                    if (snapshot11.hasData) {
                                                      return InkWell(
                                                        onTap: () async {
                                                          snapshot
                                                              .data!
                                                              .docs[index]
                                                              .reference
                                                              .update({
                                                            "cart_code": "6",
                                                          });

                                                          DateTime now =
                                                              DateTime.now();

                                                          double updateBalance =
                                                              0.0;
                                                          /**
                                                           * Vendor cancel order
                                                           * total_price refunded back to user
                                                           */
                                                          for (int i = 0;
                                                              i <
                                                                  snapshot11
                                                                      .data!
                                                                      .docs
                                                                      .length;
                                                              i++) {
                                                            if (snapshot11.data!
                                                                        .docs[i]
                                                                    [
                                                                    'username'] ==
                                                                snapshot.data!
                                                                            .docs[
                                                                        index][
                                                                    'username']) {
                                                              updateBalance = double.parse(snapshot11
                                                                          .data!
                                                                          .docs[i]
                                                                      [
                                                                      'balance']) +
                                                                  double.parse(snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'total_price']);

                                                              snapshot11
                                                                  .data!
                                                                  .docs[i]
                                                                  .reference
                                                                  .update({
                                                                "balance":
                                                                    updateBalance
                                                                        .toStringAsFixed(
                                                                            2),
                                                              });
                                                            }
                                                          }
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "Transactions")
                                                              .add({
                                                            "amount": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['total_price'],
                                                            "date":
                                                                "${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}",
                                                            "type": "4",
                                                            "username": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['username'],
                                                          });
                                                        },
                                                        child: Container(
                                                          width: 60,
                                                          height: 30,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: const Text(
                                                              "Cancel"),
                                                        ),
                                                      );
                                                    }
                                                    return const SizedBox();
                                                  })
                                            ],
                                          )
                                        : snapshot.data!.docs[index]
                                                    ['cart_code'] ==
                                                "3"
                                            ? InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    isCompleted = true;
                                                  });
                                                  // * 4. vendor prepare order
                                                  snapshot.data!.docs[index]
                                                      .reference
                                                      .update({
                                                    "cart_code": "4",
                                                  });
                                                },
                                                child: Container(
                                                  width: 70,
                                                  height: 30,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.amber,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child:
                                                      const Text("Preparing"),
                                                ),
                                              )
                                            : snapshot.data!.docs[index]
                                                        ['cart_code'] ==
                                                    "4"
                                                ? InkWell(
                                                    onTap: () async {
                                                      // * 4. vendor prepare order
                                                      snapshot.data!.docs[index]
                                                          .reference
                                                          .update({
                                                        "cart_code": "5",
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 70,
                                                      height: 30,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: Colors.amber,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: const Text(
                                                          "Completed"),
                                                    ),
                                                  )
                                                : Container(
                                                    width: 80,
                                                    height: 30,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 2),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.green),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child:
                                                        const Text("Completed"),
                                                  ),
                                  ],
                                ),

                                //conversation row
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "#${snapshot.data!.docs[index]['order_number']}"),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ConversationScreen(
                                                        recipient: snapshot
                                                                .data!
                                                                .docs[index]
                                                            ['username'],
                                                        sender: snapshot.data!
                                                                .docs[index]
                                                            ['vendor'])));
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Text("Chat")),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        } else if (snapshot.data!.docs[index]['cart_code'] ==
                            "6") {
                          return const SizedBox();
                        }
                        return const SizedBox();
                      });
                }
                return const SizedBox();
              }),
        ]),
      ),
    );
  }
}
