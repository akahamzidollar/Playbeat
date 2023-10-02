import 'package:flutter/material.dart';
import 'package:playbeat/Widgets/text_field_container.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Icon icon;
  final String hintText;
  final String? Function(String?)? validator;

  const RoundedTextField({
    Key? key,
    this.controller,
    required this.icon,
    required this.hintText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        decoration: InputDecoration(
          icon: icon,
          iconColor: Colors.deepPurple,
          hintText: hintText,
          border: InputBorder.none,
        ),
        validator: validator,
      ),
    );
  }
}
