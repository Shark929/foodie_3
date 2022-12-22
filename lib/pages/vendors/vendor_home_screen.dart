import 'package:flutter/material.dart';
import 'package:foodie_3/constants/constant.dart';
import 'package:foodie_3/pages/vendors/vendor_dashboard.dart';
import 'package:foodie_3/pages/vendors/vendor_menu_screen.dart';
import 'package:foodie_3/pages/vendors/vendor_order_screen.dart';
import 'package:foodie_3/pages/vendors/vendor_profile_screen.dart';
import 'package:foodie_3/pages/vendors/vendor_wallet_screen.dart';

class VendorHomeScreen extends StatefulWidget {
  final String vendorUsername;
  const VendorHomeScreen({super.key, required this.vendorUsername});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  int _selectedIndex = 0;
  VendorLogin vl = VendorLogin();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      VendorDashboard(
        vendorUsername: widget.vendorUsername,
      ),
      VendorOrderScreen(
        vendorUsername: widget.vendorUsername,
      ),
      VendorMenuScreen(
        vendorUsername: widget.vendorUsername,
      ),
      VendorWalletScreen(
        vendorUsername: widget.vendorUsername,
      ),
      VendorProfileScreen(
        vendorUsername: widget.vendorUsername,
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
      ),
      body: SafeArea(child: widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_checkout,
              color: Colors.black,
            ),
            label: 'My Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box,
              color: Colors.black,
            ),
            label: 'My Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.wallet,
              color: Colors.black,
            ),
            label: 'My Earning',
          ),
          BottomNavigationBarItem(
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
