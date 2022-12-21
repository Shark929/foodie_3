import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';
import 'package:foodie_3/pages/vendors/vendor_add_menu_screen.dart';

class VendorMenuScreen extends StatefulWidget {
  final String vendorUsername;
  const VendorMenuScreen({super.key, required this.vendorUsername});

  @override
  State<VendorMenuScreen> createState() => _VendorMenuScreenState();
}

class _VendorMenuScreenState extends State<VendorMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Menu")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  snapshot.data!.docs[index]
                                                      ['image'],
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 100,
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  ['item_name'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                              "RM ${double.parse(snapshot.data!.docs[index]['price']).toStringAsFixed(2)}"),
                                        ],
                                      ),
                                      const Spacer(),
                                      // Container(
                                      //   width: 80,
                                      //   height: 30,
                                      //   alignment: Alignment.center,
                                      //   decoration: BoxDecoration(
                                      //       color: Colors.red,
                                      //       borderRadius:
                                      //           BorderRadius.circular(8)),
                                      //   child: Text("Available"),
                                      // ),
                                    ],
                                  ),
                                );
                              });
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
            ButtonComponent1(
                buttonTitle: "Add Menu",
                buttonFunction: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VendorAddMenu(username: widget.vendorUsername)));
                })
          ],
        ),
      ),
    );
  }
}
