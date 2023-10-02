import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:playbeat/Controllers/bindings.dart';
import 'package:playbeat/Controllers/user_controller.dart';
import 'package:playbeat/Models/user_model.dart';
import 'package:playbeat/Services/db_services.dart';
import 'package:playbeat/Utilities/global_variables.dart';
import 'package:playbeat/Utilities/overlays_widgets.dart';
import 'package:playbeat/pages/Home/home_page.dart';
import 'package:playbeat/pages/Music/songs_view.dart';
import 'package:playbeat/pages/main_screen.dart';
// import 'package:playbeat/pages/Auth/verify_email.dart';
// import 'package:playbeat/pages/main_screen.dart';

class AuthController extends GetxController {
  static const admin = 'admin';
  RxBool isVisible = false.obs;
  RxBool isConfirmPassword = true.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  User? get user => firebaseUser.value;

  @override
  void onInit() {
    firebaseUser.bindStream(auth.authStateChanges());
    if (user != null) {
      log(user!.uid);
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _intialScreen);
  }

  _intialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const MainScreen());
    } else {
      Get.offAll(() => const HomePage(), binding: InitBinding());
    }
  }

  Future<void> register(UserModel userModel, String password) async {
    try {
      loadingOverlay("Signing up");
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: password,
      );
      userModel.userId = userCredential.user!.uid;
      await DBServices().createUser(userModel);
    } on FirebaseException catch (e) {
      Get.back();
      errorOverlay(e.message.toString());
      log(e.message.toString());
    } catch (e) {
      Get.back();
      log(e.toString());
      errorOverlay(e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      loadingOverlay('Logging in');
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.back();
      errorOverlay(e.message.toString());
      log(e.message.toString());
    }
  }

  Future<bool> adminLogin(String email, String password) async {
    try {
      loadingOverlay('Authenticating');
      final result = await firestore.collection(admin).doc('adminLogin').get();
      String adminEmail = result.get('adminEmail');
      String adminPassword = result.get('adminPassword');

      if (adminEmail != email) {
        Get.back();
        errorOverlay('Email id is incorrect');
        return false;
      } else if (adminPassword != password) {
        Get.back();
        errorOverlay('Password is incorrect');
        return false;
      } else if (adminEmail == email && adminPassword == password) {
        Get.back();
        return true;
      } else {
        Get.back();
        errorOverlay('Something went wrong');
        return false;
      }
    } catch (e) {
      Get.back();
      errorOverlay(e.toString());
      return false;
    }
  }

  void logout() async {
    isPlaying = false.obs;
    currentAudioText = ''.obs;
    isAudioLoading = false.obs;

    player.dispose();
    isSignedIn.value = false;
    userID.value = '';
    Get.find<UserController>().clearUser();
    await auth.signOut();
  }
}
