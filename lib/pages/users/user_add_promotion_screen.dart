import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PromotionScreen extends StatefulWidget {
  final String username;
  const PromotionScreen({super.key, required this.username});

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  bool isApplied = false;
  List list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Promotion')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 80,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      color: Colors.amber,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]['title'],
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]
                                                ['amount'],
                                            style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            "#${snapshot.data!.docs[index]['code']}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection("Cart")
                                            .snapshots(),
                                        builder: (context, snapshot11) {
                                          int userIndex = 0;
                                          if (snapshot11.hasData) {
                                            for (int i = 0;
                                                i <
                                                    snapshot11
                                                        .data!.docs.length;
                                                i++) {
                                              if (snapshot11.data!.docs[i]
                                                          ['cart_code'] ==
                                                      "1" &&
                                                  snapshot11.data!.docs[i]
                                                          ['username'] ==
                                                      widget.username &&
                                                  snapshot11.data!.docs[i]
                                                          ['promotion_code'] ==
                                                      snapshot.data!.docs[index]
                                                          ['code']) {
                                                isApplied = true;

                                                userIndex = i;
                                              }
                                            }
                                            return InkWell(
                                              onTap: () {
                                                if (isApplied == true) {
                                                  snapshot11.data!
                                                      .docs[userIndex].reference
                                                      .update({
                                                    "promotion_code": snapshot
                                                        .data!
                                                        .docs[index]['code'],
                                                  });
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 80,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  isApplied
                                                      ? "Applied"
                                                      : "Apply",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            );
                                          }
                                          return const SizedBox();
                                        })
                                  ],
                                ));
                          });
                    }
                    return const SizedBox();
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
