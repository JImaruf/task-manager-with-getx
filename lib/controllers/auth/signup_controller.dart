import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../utils/api_url.dart';
import '../../utils/app_strings.dart';


class SignupController extends GetxController {
  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  Future<bool> signUp(
    String email,
    String firstName,
    String lastName,
    String mobile,
    String password,
  ) async {
    bool isSuccess = false;

    Map<String, dynamic> requestData = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": ""
    };

    final NetworkResponse response = await NetworkCaller.postResponse(
      ApiUrl.registration,
      body: requestData,
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? AppStrings.signupErrorMessage;
      isSuccess = false;
    }

    return isSuccess;
  }
}
