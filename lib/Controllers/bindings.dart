import 'dart:developer';
import 'package:get/get.dart';
import 'package:playbeat/Controllers/auth_controller.dart';
import 'package:playbeat/Controllers/user_controller.dart';
import 'package:playbeat/Utilities/global_variables.dart';

class InitBinding extends Bindings {
  final authCntrlr = Get.put<AuthController>(AuthController());
  @override
  void dependencies() {
    if (authCntrlr.user != null) {
      isSignedIn.value = true;
      userID.value = authCntrlr.user!.uid;
      log('User Found:::: ${userID.value}');
      Get.put(UserController()).onInit();
    } else {
      log('user not found');
      userID.value = '';
      isSignedIn.value = false;
      Get.put(UserController());
    }
  }
}
