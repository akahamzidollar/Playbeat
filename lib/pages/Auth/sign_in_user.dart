import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playbeat/Controllers/auth_controller.dart';
import 'package:playbeat/Models/user_model.dart';
import 'package:playbeat/Utilities/input_valiators.dart';
import 'package:playbeat/pages/Auth/forgot_password.dart';
import 'package:playbeat/Widgets/round_button.dart';
import 'package:playbeat/Widgets/rounded_password_field.dart';
import 'package:playbeat/Widgets/rounded_text_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());
  bool isLogin = true;
  // EmailAuth emailAuth = EmailAuth(sessionName: 'Sample Session');
  // late EmailAuth emailAuth;

  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize the package
  //   emailAuth = EmailAuth(
  //     sessionName: "Sample session",
  //   );
  // }

  // void sendOtp() async {
  //   var res = await emailAuth.sendOtp(
  //       recipientMail: _emailController.text, otpLength: 6);
  //   if (res) {
  //     log('Otp sent');
  //   } else {
  //     log('Otp not send');
  //   }
  // }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'User\'s Login' : 'User\'s Signup'),
      ),
      backgroundColor: const Color.fromARGB(255, 238, 236, 247),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 35, vertical: isLogin ? 30 : 20),
                  child: Column(
                    children: [
                      const Image(
                        height: 250,
                        image: AssetImage('assets/images/headphone.png'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (!isLogin)
                        RoundedTextField(
                          controller: _nameController,
                          icon: const Icon(Icons.person),
                          hintText: 'Enter your name',
                          validator: requiredValidator,
                        ),
                      const SizedBox(
                        height: 25,
                      ),
                      RoundedTextField(
                        controller: _emailController,
                        icon: const Icon(Icons.email),
                        hintText: 'Enter your Email',
                        validator: emailValidator,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Obx(
                        () => RoundedPasswordField(
                          controller: _passwordController,
                          icon: const Icon(Icons.lock),
                          hintText: 'Enter your password',
                          onChanged: (value) {
                            log(value);
                          },
                          onPressed: () {
                            authController.isConfirmPassword.value =
                                !authController.isConfirmPassword.value;
                          },
                          isVisible: authController.isConfirmPassword.value,
                          validator:
                              isLogin ? requiredValidator : passwordValidator,
                        ),
                      ),
                      isLogin == true
                          ? const SizedBox(
                              height: 25,
                            )
                          : const SizedBox(
                              height: 35,
                            ),
                      RoundButton(
                        size: size,
                        text: isLogin ? 'Login' : 'Signup',
                        onPress: () async {
                          if (_formkey.currentState!.validate()) {
                            if (!isLogin) {
                              UserModel userModel = UserModel(
                                  name: _nameController.text,
                                  email: _emailController.text);

                              AuthController.instance.register(
                                userModel,
                                _passwordController.text,
                              );
                            } else {
                              AuthController.instance.login(
                                _emailController.text.trim(),
                                _passwordController.text,
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (isLogin)
                        GestureDetector(
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.red,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          onTap: () => Get.to(() => const ForgotPassword()),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (isLogin)
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Dont have an account  ",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: 'Register?',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    log('Hello');
                                    setState(() {
                                      isLogin = false;
                                    });
                                  },
                                style: const TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                ),
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
