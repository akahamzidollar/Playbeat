import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playbeat/Controllers/auth_controller.dart';
import 'package:playbeat/Models/user_model.dart';
import 'package:playbeat/Services/db_services.dart';
import 'package:playbeat/Utilities/global_variables.dart';
import 'package:playbeat/pages/About/about_us.dart';
import 'package:playbeat/pages/PrivacyPolicy/privacy_policy.dart';
import 'package:playbeat/pages/main_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 154,
            width: double.infinity,
            color: Colors.deepPurple,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  iconWithText(
                      icon: Icons.music_note,
                      iconSize: 35,
                      text: 'Play the Beat',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  const SizedBox(
                    height: 15,
                  ),
                  userID.value != ''
                      ? FutureBuilder<UserModel>(
                          future: DBServices().getUser(userID.value),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasData) {
                              return iconWithText(
                                icon: Icons.person,
                                iconSize: 22,
                                text: '${snapshot.data?.name}',
                                fontSize: 16,
                              );
                            } else {
                              return const Text('User name not found');
                            }
                          })
                      : iconWithText(
                          icon: Icons.person,
                          iconSize: 22,
                          text: 'Guest User',
                          fontSize: 16,
                        ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                drawerItem(text: 'Version 1.0.0', onPress: () {}),
                drawerItem(
                  icon: Icons.privacy_tip_outlined,
                  text: 'Privacy Policy',
                  onPress: () {
                    Get.to(() => const PrivacyPolicy());
                  },
                ),
                drawerItem(
                    icon: Icons.info_outline,
                    text: 'About',
                    onPress: () {
                      Get.to(() => const AboutUs());
                    }),
                userID.value != ''
                    ? drawerItem(
                        icon: Icons.logout,
                        text: 'Logout',
                        onPress: () {
                          AuthController.instance.logout();
                        })
                    : drawerItem(
                        icon: Icons.arrow_back,
                        text: 'Login',
                        onPress: () {
                          Get.off(() => const MainScreen());
                        }),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row iconWithText({
    IconData? icon,
    double? iconSize,
    required String text,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: iconSize,
          color: Colors.white,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        )
      ],
    );
  }

  Column drawerItem(
      {required String text,
      IconData? icon,
      required void Function()? onPress}) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: onPress,
          child: Row(
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 25,
                ),
              icon != null
                  ? const SizedBox(width: 20)
                  : const SizedBox(width: 0),
              Text(
                text,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          thickness: 1.5,
        ),
      ],
    );
  }
}
