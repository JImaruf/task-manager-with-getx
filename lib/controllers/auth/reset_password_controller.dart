import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../utils/api_url.dart';
import '../../utils/app_strings.dart';


class ResetPasswordController extends GetxController {
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  Future<bool> resetPassword(String email, String otp, String password) async {
    bool isSuccess = false;

    Map<String, dynamic> requestData = {
      "email": email,
      "OTP": otp,
      "password": password,
    };

    final NetworkResponse response = await NetworkCaller.postResponse(
      ApiUrl.recoverResetPass,
      body: requestData,
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? AppStrings.resetPasswordErrorMessage;
      isSuccess = false;
    }

    return isSuccess;
  }
}
