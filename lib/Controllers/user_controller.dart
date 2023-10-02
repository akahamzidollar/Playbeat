import 'package:get/get.dart';
import 'package:playbeat/Models/user_model.dart';
import 'package:playbeat/Services/db_services.dart';
import 'package:playbeat/Utilities/global_variables.dart';

class UserController extends GetxController {
  Rxn<UserModel> usersData = Rxn<UserModel>();
  UserModel? get user => usersData.value;

  @override
  void onInit() {
    if (isSignedIn.value) {
      usersData
          .bindStream(Stream.fromFuture(DBServices().getUser(userID.value)));
    }
    super.onInit();
  }

  void clearUser() {
    usersData.value = UserModel();
  }
}
