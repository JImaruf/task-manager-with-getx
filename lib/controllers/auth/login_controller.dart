import 'package:get/get.dart';
import 'package:task_manager_with_getx/controllers/auth_shared_preferences_controller.dart';
import 'package:task_manager_with_getx/data/model/login_model.dart';
import 'package:task_manager_with_getx/data/model/network_response.dart';

import '../../data/network_caller/network_caller.dart';
import '../../utils/api_url.dart';
import '../../utils/app_strings.dart';


class LoginController extends GetxController {
  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password, bool isCheckValue) async {
    bool isSuccess = false;

    Map<String, dynamic> requestData = {
      "email": email,
      "password": password,
    };

    final NetworkResponse response = await NetworkCaller.postResponse(
      ApiUrl.login,
      body: requestData,
    );

    if (response.responseData != null && response.responseData['status'] == 'success') {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthSharedPreferencesController.saveUserAccessToken(loginModel.token!);
      await AuthSharedPreferencesController.saveUserData(loginModel.userModel!);
      await AuthSharedPreferencesController.saveRememberMeStatus(isCheckValue);

      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? AppStrings.loginErrorMessage;
      isSuccess = false;
    }

    return isSuccess;
  }
}
