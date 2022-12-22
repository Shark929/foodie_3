import 'package:flutter/material.dart';

class EditTextField extends StatefulWidget {
  final TextEditingController controller;

  final String label;
  final String hintText;
  final Function() editFunction;
  EditTextField(
      {super.key,
      required this.controller,
      required this.label,
      required this.hintText,
      required this.editFunction});

  @override
  State<EditTextField> createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {
  bool isFilled = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(widget.label),
            const Spacer(),
            isFilled == true
                ? InkWell(
                    onTap: () {
                      widget.editFunction();
                      setState(() {
                        isFilled = false;
                        widget.controller.clear();
                      });
                    },
                    child: const Text(
                      "Done",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.amber),
                    ),
                  )
                : const Text("Done"),
          ],
        ),
        TextField(
          controller: widget.controller,
          onChanged: (value) {
            if (widget.controller.text.isNotEmpty) {
              setState(() {
                isFilled = true;
              });
            } else {
              setState(() {
                isFilled = false;
              });
            }
          },
          decoration: InputDecoration(hintText: widget.hintText),
        ),
      ],
    );
  }
}
