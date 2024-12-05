import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;

  const MyFormField(
      {super.key,
      required this.hint,
      required this.textEditingController,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        controller: textEditingController,
        validator: validator,
        decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}
