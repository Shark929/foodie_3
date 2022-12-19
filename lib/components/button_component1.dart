import 'package:flutter/material.dart';

class ButtonComponent1 extends StatelessWidget {
  final String buttonTitle;
  final Function() buttonFunction;
  const ButtonComponent1(
      {super.key, required this.buttonTitle, required this.buttonFunction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: buttonFunction,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 242, 184, 10),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            buttonTitle,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ));
  }
}
