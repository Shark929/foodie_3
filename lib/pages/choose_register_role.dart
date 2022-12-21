import 'package:flutter/material.dart';
import 'package:foodie_3/pages/users/user_register_screen.dart';
import 'package:foodie_3/pages/vendors/vendor_register_screen.dart';

class ChooseRegisterRolePage extends StatelessWidget {
  const ChooseRegisterRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VendorRegisterScreen(),
                    ),
                  );
                },
                child: Text("Vendor")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserRegisterScreen(),
                    ),
                  );
                },
                child: Text("User"))
          ],
        ),
      ),
    );
  }
}
