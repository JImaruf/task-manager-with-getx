import 'package:get/get.dart';

import '../data/model/network_response.dart';
import '../data/model/task_list_wrapper_model.dart';
import '../data/model/task_model.dart';
import '../data/network_caller/network_caller.dart';
import '../utils/api_url.dart';
import '../utils/app_strings.dart';

class CompleteTaskController extends GetxController {
  bool _completeTaskInProgress = false;
  List<TaskModel> _completeTaskList = [];
  String _errorMessage = '';

  bool get completeTaskInProgress => _completeTaskInProgress;

  List get completeTaskList => _completeTaskList;

  String get errorMessage => _errorMessage;

  @override
  void onInit() {
    super.onInit();
    getCompleteTask();
  }

  Future<bool> getCompleteTask() async {
    bool isSuccess = false;

    _completeTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getResponse(ApiUrl.completeTask);

    if (response.isSuccess) {
      isSuccess = true;
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _completeTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage ?? AppStrings.somethingWentWrong;
    }

    _completeTaskInProgress = false;
    update();

    return isSuccess;
  }
}
