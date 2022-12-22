import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';

class UserOrderScreen extends StatefulWidget {
  final String username;
  const UserOrderScreen({super.key, required this.username});

  @override
  State<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  TextEditingController reasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Cart").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            if (snapshot.data!.docs[i]['username'] == widget.username &&
                snapshot.data!.docs[i]['cart_code'] != "1" &&
                snapshot.data!.docs[i]['cart_code'] != "0" &&
                snapshot.data!.docs[i]['cart_code'] != "5" &&
                snapshot.data!.docs[i]['cart_code'] != "6") {
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 120,
                        width: 120,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 234, 234, 234),
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.asset(
                          "assets/cooking.png",
                          width: 80,
                          height: 80,
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Our chef is preparing your food...",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.circle_outlined,
                                  color: int.parse(snapshot.data!.docs[i]
                                              ['cart_code']) >
                                          2
                                      ? Colors.amber
                                      : Colors.black,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                const Text("Your order has been received"),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 2,
                              height: 20,
                              color: int.parse(
                                          snapshot.data!.docs[i]['cart_code']) >
                                      2
                                  ? Colors.amber
                                  : Colors.black,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle_outlined,
                                  color: int.parse(snapshot.data!.docs[i]
                                              ['cart_code']) >
                                          3
                                      ? Colors.amber
                                      : Colors.black,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                const Text("Chef is cooking"),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 2,
                              height: 20,
                              color: int.parse(
                                          snapshot.data!.docs[i]['cart_code']) >
                                      3
                                  ? Colors.amber
                                  : Colors.black,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle_outlined,
                                  color: int.parse(snapshot.data!.docs[i]
                                              ['cart_code']) >
                                          4
                                      ? Colors.amber
                                      : Colors.black,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                const Text("Your order is ready"),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //expansiion panel
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ExpansionTile(
                          title: const Text(
                            "Order Details",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  if (snapshot.data!.docs[index]['username'] ==
                                              widget.username &&
                                          snapshot.data!.docs[index]
                                                  ['cart_code'] ==
                                              "2" ||
                                      snapshot.data!.docs[index]['username'] ==
                                              widget.username &&
                                          snapshot.data!.docs[index]
                                                  ['cart_code'] ==
                                              "3" ||
                                      snapshot.data!.docs[index]['username'] ==
                                              widget.username &&
                                          snapshot.data!.docs[index]
                                                  ['cart_code'] ==
                                              "4" &&
                                          snapshot.data!.docs[index]
                                                  ['username'] ==
                                              widget.username &&
                                          snapshot.data!.docs[index]
                                                  ['cart_code'] ==
                                              "5") {
                                    return ListTile(
                                      title: Text(snapshot.data!.docs[index]
                                          ['item_name']),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data!.docs[index]
                                              ['choice']),
                                          Text(
                                              "x${snapshot.data!.docs[index]['quantity']}"),
                                          Text(
                                              "RM ${snapshot.data!.docs[index]['price']}"),
                                        ],
                                      ),
                                      trailing: Text(
                                          "RM ${snapshot.data!.docs[index]['total_price']}"),
                                    );
                                  }
                                  return const SizedBox();
                                })
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      snapshot.data!.docs[i]['username'] == widget.username &&
                              snapshot.data!.docs[i]['cart_code'] == "2"
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: ButtonComponent1(
                                  buttonTitle: "Cancel Order",
                                  buttonFunction: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                              child: Container(
                                                height: 300,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 20),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: const Color.fromRGBO(
                                                        230, 230, 230, 0)),
                                                child: Column(
                                                  children: [
                                                    const Text(
                                                      "Confirm cancel?",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Text(
                                                        "Please state your reason"),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                        width: 250,
                                                        height: 40,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 16),
                                                        decoration: BoxDecoration(
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                221,
                                                                221,
                                                                221),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                        child: TextField(
                                                          controller:
                                                              reasonController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      "Enter your reason..."),
                                                        )),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        snapshot.data!.docs[i]
                                                            .reference
                                                            .update({
                                                          "cart_code": "0",
                                                          "reason":
                                                              reasonController
                                                                  .text,
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 250,
                                                        height: 50,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                        child: const Text(
                                                          "Confirm",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
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
                                    // snapshot.data!.docs[i].reference.update({
                                    //   "cart_code": "2",
                                    //   "dine_in_code": isDineIn,
                                    //   "pick_up": pickUpController.text,
                                    // });
                                  }),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              );
            } else if (snapshot.data!.docs[i]['username'] == widget.username &&
                snapshot.data!.docs[i]['cart_code'] == "6") {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                      "Your order has been cancelled by vendor due to lack of available materials"),
                ),
              );
            } else if (snapshot.data!.docs[i]['username'] != widget.username) {
              return const Center(
                child: Text("Navigate to home screen to make order now"),
              );
            }
          }
        }
        return const Center(
          child: Text("Navigate to home screen to make order now"),
        );
      },
    );
  }
}
