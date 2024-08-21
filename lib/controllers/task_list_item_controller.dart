import 'package:get/get.dart';

import '../data/model/network_response.dart';
import '../data/model/task_model.dart';
import '../data/network_caller/network_caller.dart';
import '../utils/api_url.dart';
import '../utils/app_strings.dart';


class TaskListItemController extends GetxController {
  final TaskModel taskModel;

  TaskListItemController({required this.taskModel});

  String _dropDownValue = '';
  String _errorMessage = "";
  final List<String> _statusList = [
    'New',
    'Progress',
    'Completed',
    'Canceled',
  ];

  String get dropDownValue => _dropDownValue;

  String get errorMessage => _errorMessage;

  List<String> get statusList => _statusList;

  @override
  void onInit() {
    super.onInit();
    _dropDownValue = taskModel.status!;
  }

  Future<bool> updateTaskStatus(String status) async {
    bool isSuccess = false;

    NetworkResponse response = await NetworkCaller.getResponse(
      ApiUrl.updateTaskStatus(taskModel.sId!, status),
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? AppStrings.taskUpdateFailed;
      isSuccess = false;
    }

    return isSuccess;
  }

  Future<bool> deleteTask() async {
    bool isSuccess = false;

    NetworkResponse response = await NetworkCaller.getResponse(
      ApiUrl.deleteTask(taskModel.sId!),
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? AppStrings.taskDeleteFailed;
      isSuccess = false;
    }

    return isSuccess;
  }

  void setDropDownValue(String value) {
    _dropDownValue = value;
    update();
  }
}
