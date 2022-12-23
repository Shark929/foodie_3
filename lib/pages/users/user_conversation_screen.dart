import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserConversationScreen extends StatefulWidget {
  final String recipient;
  final String userisSender;
  const UserConversationScreen(
      {super.key, required this.userisSender, required this.recipient});

  @override
  State<UserConversationScreen> createState() => _UserConversationScreenState();
}

class _UserConversationScreenState extends State<UserConversationScreen> {
  TextEditingController chatController = TextEditingController();
  String chatValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userisSender),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Chat")
                      .orderBy("time", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data!.docs[index]['chat_id'] ==
                                "${widget.userisSender}&&${widget.recipient}") {
                              return Container(
                                margin: snapshot.data!.docs[index]['username']
                                        .toString()
                                        .isNotEmpty
                                    ? const EdgeInsets.only(
                                        left: 150, bottom: 16)
                                    : const EdgeInsets.only(
                                        right: 150, bottom: 16),
                                alignment: snapshot
                                        .data!.docs[index]['username']
                                        .toString()
                                        .isNotEmpty
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                    color: snapshot
                                            .data!.docs[index]['username']
                                            .toString()
                                            .isNotEmpty
                                        ? Colors.amber
                                        : Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(snapshot.data!.docs[index]['chat']),
                              );
                            } else if (snapshot.data!.docs[index]['chat_id'] !=
                                "${widget.userisSender}&&${widget.recipient}") {
                              return const SizedBox();

                              // Column(
                              //   children: [
                              //     SizedBox(
                              //       height: MediaQuery.of(context).size.height *
                              //           0.3,
                              //     ),
                              //     Text("Start conversation now ... "),
                              //   ],
                              // );
                            }
                            return const SizedBox();
                          });
                    }
                    return const SizedBox();
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.amber, width: 2)),
                    child: TextField(
                        controller: chatController,
                        onChanged: (value) {
                          setState(() {
                            chatValue = value;
                          });
                        },
                        decoration: const InputDecoration(
                            hintText: "Type your message ...",
                            border: InputBorder.none)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      DateTime now = DateTime.now();
                      if (chatValue != "") {
                        FirebaseFirestore.instance
                            .collection("Chat")
                            .orderBy("time")
                            .firestore
                            .collection("Chat")
                            .add({
                          "chat_id":
                              "${widget.userisSender}&&${widget.recipient}",
                          "vendor": "",
                          "username": widget.userisSender,
                          "chat": chatValue,
                          "time": now,
                        }).then((value) {
                          setState(() {
                            chatController.clear();
                          });
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.amber),
                      child: Image.asset(
                        "assets/send.png",
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
