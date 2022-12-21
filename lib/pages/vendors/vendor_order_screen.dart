import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/services/local_notification_service.dart';

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
  late final LocalNotificationService service;

  @override
  void initState() {
    service = LocalNotificationService();
    service.initialize();
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
                            snapshot.data!.docs[index]['cart_code'] != "1" &&
                            snapshot.data!.docs[index]['cart_code'] != "0" &&
                            snapshot.data!.docs[index]['cart_code'] != "6") {
                          return Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.amber, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index]['item_name'],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(snapshot.data!.docs[index]['choice']),
                                    Text(snapshot.data!.docs[index]['quantity']
                                        .toString()),
                                    Text(snapshot.data!.docs[index]['price']),
                                  ],
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    /**
                                     * here is the vendor accept order button
                                     * cart_code should be updated from 3 to 3
                                     */

                                    snapshot.data!.docs[index].reference
                                        .update({
                                      "cart_code": "3",
                                    });
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text("Accept"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                InkWell(
                                  onTap: () async {
                                    snapshot.data!.docs[index].reference
                                        .update({
                                      "cart_code": "6",
                                    });
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text("Cancel"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.data!.docs[index]['cart_code'] ==
                            "6") {
                          return const SizedBox();
                        }
                        return const Center(
                          child: Text("There is no order at the moment"),
                        );
                      });
                }
                return const SizedBox();
              }),
        ]),
      ),
    );
  }
}
