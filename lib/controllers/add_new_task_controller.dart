import 'package:get/get.dart';

import '../data/model/network_response.dart';
import '../data/network_caller/network_caller.dart';
import '../utils/api_url.dart';
import '../utils/app_strings.dart';


class AddNewTaskController extends GetxController {
  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  Future<bool> addNewTask(title, description) async {
    bool isSuccess = false;

    Map<String, dynamic> requestData = {
      "title": title,
      "description": description,
      "status": "New",
    };

    NetworkResponse response = await NetworkCaller.postResponse(
      ApiUrl.createTask,
      body: requestData,
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? AppStrings.addNewTaskFailed;
      isSuccess = false;
    }

    return isSuccess;
  }
}
