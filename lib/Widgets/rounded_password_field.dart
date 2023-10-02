import 'package:flutter/material.dart';
import 'package:playbeat/Widgets/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final TextEditingController? controller;
  final bool isVisible;
  final Icon icon;
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String) onChanged;
  final void Function() onPressed;
  const RoundedPasswordField({
    Key? key,
    this.controller,
    required this.icon,
    required this.hintText,
    required this.onChanged,
    required this.isVisible,
    required this.onPressed,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: icon,
          iconColor: Colors.deepPurple,
          hintText: hintText,
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.visibility),
          ),
        ),
        obscureText: isVisible,
        validator: validator,
      ),
    );
  }
}
