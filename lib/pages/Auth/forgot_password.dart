import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playbeat/Utilities/input_valiators.dart';
import 'package:playbeat/Utilities/overlays_widgets.dart';
import 'package:playbeat/Utilities/snack_bar.dart';
import 'package:playbeat/Widgets/round_button.dart';
import 'package:playbeat/Widgets/rounded_text_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Reset your Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(35),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Receive an email\nto reset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundedTextField(
                  icon: const Icon(Icons.email),
                  hintText: 'Enter your email',
                  controller: _emailController,
                  validator: emailValidator,
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundButton(
                  size: size,
                  onPress: () {
                    if (_formkey.currentState!.validate()) {
                      verifyEmail();
                    }
                  },
                  text: 'Reset',
                )
              ],
            ),
          ),
        ));
  }

  Future verifyEmail() async {
    try {
      loadingOverlay('Resetting');
      log(_emailController.text);
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      Get.back();
      Utils.showSnackBar('Password reset email sent');
      Get.back();
    } on FirebaseAuthException catch (e) {
      Get.back();
      errorOverlay(e.toString());
    }
  }
}
