import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/pages/users/user_add_to_basket_screen.dart';

class UserViewVendorScreen extends StatefulWidget {
  final String username;
  final QueryDocumentSnapshot<Map<String, dynamic>> data;

  const UserViewVendorScreen({
    super.key,
    required this.data,
    required this.username,
  });

  @override
  State<UserViewVendorScreen> createState() => _UserViewVendorScreenState();
}

class _UserViewVendorScreenState extends State<UserViewVendorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.data['image']),
                        fit: BoxFit.cover)),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(150, 255, 255, 255),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "${widget.data['shop_name']} - ${widget.data['location']}",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 24, 24, 24)),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "For You",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("Menu").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (snapshot.data!.docs[index]['username'] ==
                                  widget.data['username']) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddToBasketScreen(
                                                  username: widget.username,
                                                  foodData: snapshot
                                                      .data!.docs[index],
                                                )));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data!
                                                    .docs[index]['image']),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(snapshot.data!.docs[index]
                                            ['item_name']),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                            "RM ${snapshot.data!.docs[index]['price']}"),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox();
                            }),
                      ),
                    );
                  }
                  return const SizedBox();
                }),
            const SizedBox(
              height: 100,
            ),
          ]),
        ),
      ),
    );
  }
}
