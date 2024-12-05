import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({super.key,
  required this.hintText,
  required this.textEditingController,
  this.validator});

  final String hintText;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {

  bool passwordVisible = false;
  String? hintText ;
  TextEditingController? textEditingController;
  String? Function(String?)? validator;


  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    hintText = widget.hintText;
    textEditingController = widget.textEditingController;
    validator = widget.validator;
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
            obscureText: passwordVisible,
            controller: textEditingController,
            validator: validator,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: hintText,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
              ),
              alignLabelWithHint: false,
              filled: true,
            ),
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
          ),
    );
  }
}