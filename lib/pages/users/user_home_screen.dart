import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/constants/constant.dart';
import 'package:foodie_3/pages/users/user_cart_screen.dart';
import 'package:foodie_3/pages/users/user_chatroom_screen.dart';
import 'package:foodie_3/pages/users/user_home_component.dart';
import 'package:foodie_3/pages/users/user_order_screen.dart';
import 'package:foodie_3/pages/users/user_profile_screen.dart';

class UserHomeScreen extends StatefulWidget {
  final String username;
  const UserHomeScreen({super.key, required this.username});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _selectedIndex = 0;
  VendorLogin vl = VendorLogin();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      UserHomeComponen(
        username: widget.username,
      ),
      UserOrderScreen(username: widget.username),
      UserCartScreen(
        username: widget.username,
      ),
      UserProfileScreen(
        username: widget.username,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Foodie",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Image.asset(
            "assets/notification.png",
            width: 25,
            height: 25,
          ),
          const SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserChatRoomScreen(
                            username: widget.username,
                          )));
            },
            child: Image.asset(
              "assets/chat.png",
              width: 25,
              height: 25,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.timelapse,
              color: Colors.black,
            ),
            label: 'My Order',
          ),
          BottomNavigationBarItem(
            icon: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("Cart").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      if (snapshot.data!.docs[i]['username'] ==
                          widget.username) {
                      } else if (snapshot.data!.docs[i]['username'] !=
                          widget.username) {
                        return const Icon(
                          Icons.shopping_cart_checkout,
                          color: Colors.black,
                        );
                      }
                    }
                  }
                  return const Icon(
                    Icons.shopping_cart_checkout,
                    color: Colors.black,
                  );
                }),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        backgroundColor: const Color.fromARGB(255, 187, 187, 187),
      ),
    );
  }
}
