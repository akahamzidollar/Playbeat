import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playbeat/pages/Categories/category_page.dart';
import 'package:playbeat/pages/UsersUploads/users_uploads.dart';
import 'package:playbeat/pages/Upload/upload_page.dart';

class HomeController extends GetxController {
  RxBool isAllSongsPage = true.obs;
  RxInt index = 0.obs;
  final List<Icon> items = [
    const Icon(
      Icons.home_filled,
      size: 30,
      color: Colors.white,
    ),
    const Icon(
      Icons.add,
      size: 30,
      color: Colors.white,
    ),
    const Icon(
      Icons.upload_sharp,
      size: 30,
      color: Colors.white,
    ),
  ];

  final List<Widget> pages = [
    const CategoryPage(),
    const UploadPage(),
    const UsersUploads()
  ];
}
