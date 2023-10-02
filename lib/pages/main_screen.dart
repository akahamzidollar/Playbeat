import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:playbeat/pages/Auth/sign_in_admin.dart';
import 'package:playbeat/pages/Auth/sign_in_user.dart';
import 'package:playbeat/pages/Home/home_page.dart';
import 'package:playbeat/Widgets/round_button.dart';
import 'package:playbeat/pages/Music/songs_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 236, 247),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                const Image(
                  height: 350,
                  image: AssetImage('assets/images/mic_drop.png'),
                ),
                Positioned(
                  top: 10,
                  right: 0,
                  child: TextButton(
                    child: const Text(
                      'Skip',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      player = AudioPlayer();
                      Get.off(
                        () => const HomePage(),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: const [
                  Text(
                    'Listen your',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    'favorite songs here',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Explore your favorite songs here and you have a chance to make your song viral',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 151, 149, 166),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RoundButton(
                    size: size,
                    text: 'login as user',
                    onPress: () {
                      Get.to(
                        () => const AuthScreen(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundButton(
                    size: size,
                    text: 'login as admin',
                    onPress: () {
                      Get.to(() => AdminSignIn());
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
