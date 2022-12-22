import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/pages/users/user_add_to_basket_screen.dart';
import 'package:foodie_3/pages/users/user_category_screen.dart';
import 'package:foodie_3/pages/users/user_location_screen.dart';
import 'package:foodie_3/pages/users/user_view_vendor_screen.dart';

class UserHomeComponen extends StatefulWidget {
  final String username;
  const UserHomeComponen({super.key, required this.username});

  @override
  State<UserHomeComponen> createState() => _UserHomeComponenState();
}

class _UserHomeComponenState extends State<UserHomeComponen> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  String category = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 224, 224, 224),
                    border: Border.all(
                      width: 2,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(30)),
                child: TextField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        isSearching = true;
                      });
                    } else {
                      setState(() {
                        isSearching = false;
                      });
                    }
                    setState(() {
                      category = value;
                    });
                  },
                  controller: searchController,
                  decoration: const InputDecoration(
                      hintText: "Search...",
                      icon: Icon(Icons.search),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              category == ""
                  ? Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("Category")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserCategoryScreen(
                                                        username:
                                                            widget.username,
                                                        category: snapshot.data!
                                                                .docs[index]
                                                            ['category_name'],
                                                      )));
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 20,
                                          margin:
                                              const EdgeInsets.only(right: 16),
                                          padding: const EdgeInsets.all(8),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.amber),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Text(
                                            snapshot.data!.docs[index]
                                                ["category_name"],
                                            style: const TextStyle(
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                                return const SizedBox();
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Get Promo Code Now",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          // padding:
                          //     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          height: 100,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("Promotion")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: 200,
                                          margin:
                                              const EdgeInsets.only(right: 16),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                snapshot.data!.docs[index]
                                                    ['amount'],
                                                style: const TextStyle(
                                                  fontSize: 48,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    snapshot.data!.docs[index]
                                                        ['title'],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                            ],
                                          ),
                                        );
                                      });
                                }
                                return const SizedBox();
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Order your food from",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 150,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("Vendor")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserViewVendorScreen(
                                                          username:
                                                              widget.username,
                                                          data: snapshot.data!
                                                              .docs[index],
                                                        )));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width: 130,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                            snapshot.data!
                                                                    .docs[index]
                                                                ['image'],
                                                          ),
                                                          fit: BoxFit.cover)),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    snapshot.data!.docs[index]
                                                        ['shop_name'],
                                                    style: const TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    snapshot.data!.docs[index]
                                                        ['location'],
                                                    style: const TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                }
                                return const SizedBox();
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Locations",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 100,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("Location")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserLocationScreen(
                                                          location: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ['location'],
                                                        )));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            margin: const EdgeInsets.only(
                                                right: 16),
                                            width: 100,
                                            height: 20,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.amber,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  ['location'],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        );
                                      });
                                }
                                return const SizedBox();
                              }),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    )

                  /**
               * if search input is not empty
               */
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Menu")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                if (searchController.text
                                    .toLowerCase()
                                    .contains(snapshot
                                        .data!.docs[index]['category']
                                        .toString()
                                        .toLowerCase())) {
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
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         UserViewVendorScreen(
                                      //       username: snapshot.data!.docs[index]
                                      //           ['username'],
                                      //       data: snapshot.data!.docs[index],
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 130,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
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
                                            width: 8,
                                          ),
                                          Column(
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: Text(
                                                  snapshot.data!.docs[index]
                                                      ['item_name'],
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: Text(
                                                  snapshot.data!.docs[index]
                                                      ['category'],
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return const SizedBox();
                              });
                        }
                        return const SizedBox();
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
