import 'package:flutter/material.dart';

class ApprovalScreen extends StatelessWidget {
  const ApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(8)),
              child: Image.asset(
                "assets/fork.png",
                width: 40,
                height: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text("Waiting approval from admin..."),
          ],
        ),
      ),
    );
  }
}
