import 'package:flutter/material.dart';

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({super.key});

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  border: Border.all(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const Spacer(),
              Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  border: Border.all(color: Colors.purple, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const Spacer(),
              Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  border: Border.all(color: Colors.yellow, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const Spacer(),
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  border: Border.all(color: Colors.orange, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  border: Border.all(color: Colors.pink, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const Spacer(),
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  border: Border.all(color: Colors.blueGrey, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
