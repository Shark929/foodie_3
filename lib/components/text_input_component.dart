import 'package:flutter/material.dart';

class TextInputComponent extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Function(String)? onChanged;
  final bool validator;
  final String validatorText;
  const TextInputComponent(
      {super.key,
      required this.controller,
      required this.hintText,
      this.onChanged,
      required this.obscureText,
      required this.validator,
      required this.validatorText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 212, 212, 212),
              borderRadius: BorderRadius.circular(8)),
          width: MediaQuery.of(context).size.width,
          child: TextField(
            obscureText: obscureText,
            onChanged: onChanged,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        validator
            ? Text(
                validatorText,
                style: const TextStyle(color: Colors.red),
              )
            : const SizedBox(),
      ],
    );
  }
}
