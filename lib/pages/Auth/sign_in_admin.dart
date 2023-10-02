import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playbeat/Controllers/auth_controller.dart';
import 'package:playbeat/Utilities/input_valiators.dart';
import 'package:playbeat/pages/Admin/admin_approval_page.dart';
import 'package:playbeat/Widgets/round_button.dart';
import 'package:playbeat/Widgets/rounded_password_field.dart';
import 'package:playbeat/Widgets/rounded_text_field.dart';

class AdminSignIn extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AdminSignIn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin\'s Login'),
      ),
      backgroundColor: const Color.fromARGB(255, 238, 236, 247),
      body: Obx(
        () => SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 25),
                    child: Column(
                      children: [
                        const Image(
                          height: 300,
                          image: AssetImage('assets/images/Admin.png'),
                        ),
                        const SizedBox(height: 30),
                        RoundedTextField(
                            icon: const Icon(Icons.person),
                            controller: emailController,
                            hintText: 'Enter admin email',
                            validator: emailValidator),
                        const SizedBox(
                          height: 30,
                        ),
                        RoundedPasswordField(
                            icon: const Icon(Icons.lock),
                            hintText: 'Enter admin password',
                            onChanged: (value) {
                              log(value);
                            },
                            controller: passwordController,
                            onPressed: () {
                              authController.isVisible.value =
                                  !authController.isVisible.value;
                            },
                            isVisible: authController.isVisible.value,
                            validator: passwordValidator),
                        const SizedBox(
                          height: 40,
                        ),
                        RoundButton(
                          size: size,
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              bool isAdmin =
                                  await AuthController.instance.adminLogin(
                                emailController.text.trim(),
                                passwordController.text,
                              );
                              if (isAdmin) {
                                Get.off(() => const AdminApproval());
                              }
                            }
                          },
                          text: 'Login',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
