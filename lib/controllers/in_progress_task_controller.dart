import 'package:get/get.dart';

import '../data/model/network_response.dart';
import '../data/model/task_list_wrapper_model.dart';
import '../data/model/task_model.dart';
import '../data/network_caller/network_caller.dart';
import '../utils/api_url.dart';
import '../utils/app_strings.dart';


class InProgressTaskController extends GetxController {
  bool _inProgressTaskInProgress = false;
  List<TaskModel> _inProgressTaskList = [];
  String _errorMessage = '';

  bool get inProgressTaskInProgress => _inProgressTaskInProgress;

  List get inProgressTaskList => _inProgressTaskList;

  String get errorMessage => _errorMessage;

  @override
  void onInit() {
    super.onInit();
    getInProgressTask();
  }

  Future<bool> getInProgressTask() async {
    bool isSuccess = false;

    _inProgressTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getResponse(ApiUrl.progressTask);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _inProgressTaskList = taskListWrapperModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? AppStrings.somethingWentWrong;
      isSuccess = false;
    }

    _inProgressTaskInProgress = false;
    update();

    return isSuccess;
  }
}
