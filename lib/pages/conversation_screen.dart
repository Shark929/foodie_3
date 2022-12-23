import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String recipient;
  final String sender;
  const ConversationScreen(
      {super.key, required this.sender, required this.recipient});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController chatController = TextEditingController();
  String chatValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sender),
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
                                "${widget.sender}&&${widget.recipient}") {
                              return Container(
                                margin: snapshot.data!.docs[index]['vendor']
                                        .toString()
                                        .isNotEmpty
                                    ? const EdgeInsets.only(
                                        left: 150, bottom: 16)
                                    : const EdgeInsets.only(
                                        right: 150, bottom: 16),
                                alignment: snapshot.data!.docs[index]['vendor']
                                        .toString()
                                        .isNotEmpty
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                    color: snapshot.data!.docs[index]['vendor']
                                            .toString()
                                            .isNotEmpty
                                        ? Colors.amber
                                        : Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(snapshot.data!.docs[index]['chat']),
                              );
                            } else if (snapshot.data!.docs[index]['chat_id'] !=
                                "${widget.sender}&&${widget.recipient}") {
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
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Chatroom")
                          .snapshots(),
                      builder: (context, snapshot11) {
                        if (snapshot11.hasData) {
                          for (int i = 0;
                              i < snapshot11.data!.docs.length;
                              i++) {
                            if (snapshot11.data!.docs[i]['chatroom_id'] ==
                                "${widget.sender}&&${widget.recipient}") {
                              return InkWell(
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
                                          "${widget.sender}&&${widget.recipient}",
                                      "vendor": widget.sender,
                                      "username": "",
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
                                      shape: BoxShape.circle,
                                      color: Colors.amber),
                                  child: Image.asset(
                                    "assets/send.png",
                                    width: 30,
                                    height: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              );

                              /**
                               * 
                               * later 
                               */
                            }
                          }
                        }
                        return InkWell(
                          onTap: () {
                            DateTime now = DateTime.now();

                            FirebaseFirestore.instance
                                .collection("Chatroom")
                                .add({
                              "chatroom_id":
                                  "${widget.sender}&&${widget.recipient}",
                            });

                            if (chatValue != "") {
                              FirebaseFirestore.instance
                                  .collection("Chat")
                                  .orderBy("time")
                                  .firestore
                                  .collection("Chat")
                                  .add({
                                "chat_id":
                                    "${widget.sender}&&${widget.recipient}",
                                "vendor": widget.sender,
                                "username": "",
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
                        );
                      }),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
