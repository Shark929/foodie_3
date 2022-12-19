import 'package:flutter/material.dart';

class TextInputComponent extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  const TextInputComponent(
      {super.key,
      required this.controller,
      required this.hintText,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 212, 212, 212),
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
