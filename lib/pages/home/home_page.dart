import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playbeat/Controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: Obx(
        () {
          return homeController.pages[homeController.index.value];
        },
      ),
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Colors.deepPurple,
          animationDuration: const Duration(milliseconds: 250),
          height: 55,
          onTap: (index) {
            homeController.index.value = index;
          },
          items: homeController.items,
          index: homeController.index.value,
        ),
      ),
    );
  }
}
