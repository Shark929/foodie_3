import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/pages/users/user_view_vendor_screen.dart';

class UserLocationScreen extends StatefulWidget {
  final String location;
  const UserLocationScreen({super.key, required this.location});

  @override
  State<UserLocationScreen> createState() => _UserLocationScreenState();
}

class _UserLocationScreenState extends State<UserLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.location)),
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
                      .collection("Vendor")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data!.docs[index]['location'] ==
                                widget.location) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UserViewVendorScreen(
                                        username: snapshot.data!.docs[index]
                                            ['username'],
                                        data: snapshot.data!.docs[index],
                                      ),
                                    ),
                                  );
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
                                                  ['shop_name'],
                                              style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
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
                                                  ['location'],
                                              style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
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
      )),
    );
  }
}
