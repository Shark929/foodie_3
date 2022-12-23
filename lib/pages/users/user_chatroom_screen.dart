import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/pages/users/user_conversation_screen.dart';

class UserChatRoomScreen extends StatefulWidget {
  final String username;
  const UserChatRoomScreen({super.key, required this.username});

  @override
  State<UserChatRoomScreen> createState() => _UserChatRoomScreenState();
}

class _UserChatRoomScreenState extends State<UserChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Foodie Chatroom"),
        centerTitle: true,
      ),
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
                      .collection("Chatroom")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            //filter name
                            String recipientName =
                                snapshot.data!.docs[index]['chatroom_id'];
                            final recipientNameList = recipientName.split("&&");
                            print("split " + recipientNameList[0]);

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserConversationScreen(
                                      recipient: recipientNameList[0],
                                      userisSender: widget.username,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  bottom: 16,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${recipientNameList[0]} has started conversation"),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      //Text("hello worl"),
                                    ]),
                              ),
                            );
                          });
                    }
                    return const SizedBox();
                  })
            ],
          ),
        ),
      )),
    );
  }
}
