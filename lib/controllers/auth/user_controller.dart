import 'package:get/get.dart';

import '../../data/model/user_model.dart';
import '../auth_shared_preferences_controller.dart';

class UserController extends GetxController {
  var user = UserModel().obs;

  @override
  void onInit() {
    loadUser();
    super.onInit();
  }

  void setUser(UserModel userModel) {
    user.value = userModel;
    update();
  }

  Future<void> loadUser() async {
    UserModel? userModel = await AuthSharedPreferencesController.getUserData();
    if (userModel != null) {
      user.value = userModel;
      update();
    }
  }
}
