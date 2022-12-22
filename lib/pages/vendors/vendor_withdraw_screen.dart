import 'package:flutter/material.dart';

class VendorWithdrawAmount extends StatefulWidget {
  final String vendorUsername;
  const VendorWithdrawAmount({super.key, required this.vendorUsername});

  @override
  State<VendorWithdrawAmount> createState() => _VendorWithdrawAmountState();
}

class _VendorWithdrawAmountState extends State<VendorWithdrawAmount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Withdraw"),
      ),
      body: SafeArea(
          child: Column(
        children: [],
      )),
    );
  }
}
