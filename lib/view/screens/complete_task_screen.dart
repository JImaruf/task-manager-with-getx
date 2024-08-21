import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/complete_task_controller.dart';
import '../../controllers/internet_connection_controller.dart';
import '../../utils/app_color.dart';
import '../../utils/app_strings.dart';
import '../widgets/custom_toast.dart';
import '../widgets/no_internet_widget.dart';
import '../widgets/no_task_widget.dart';
import '../widgets/section_header.dart';
import '../widgets/shimmer/task_item_shimmer_widget.dart';
import '../widgets/task_list_item.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: GetBuilder<InternetConnectionController>(
        builder: (internetConnectionController) {
          return !internetConnectionController.connectionStatus
              ? const NoInternetWidget()
              : GetBuilder<CompleteTaskController>(
                  builder: (completeTaskController) {
                    return RefreshIndicator(
                      color: AppColor.themeColor,
                      onRefresh: () async {
                        _getCompleteTask(completeTaskController);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: completeTaskController.completeTaskInProgress
                            ? const TaskItemShimmerWidget()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SectionHeader(title: "Complete Task"),
                                  completeTaskController.completeTaskList.isEmpty
                                      ? const Expanded(
                                          child: NoTaskWidget(
                                            height: double.maxFinite,
                                            text: AppStrings.noTaskAvailable,
                                          ),
                                        )
                                      : Expanded(
                                          child: ListView.builder(
                                            itemCount:
                                                completeTaskController.completeTaskList.length,
                                            itemBuilder: (context, index) {
                                              return TaskListItem(
                                                taskModel:
                                                    completeTaskController.completeTaskList[index],
                                                labelBgColor: AppColor.completeLabelColor,
                                                onUpdateTask: () {
                                                  _getCompleteTask(completeTaskController);
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                ],
                              ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  void _getCompleteTask(CompleteTaskController completeTaskController) async {
    final bool result = await completeTaskController.getCompleteTask();

    if (!result) {
      if (mounted) {
        showCustomToast(
          completeTaskController.errorMessage,
          Icons.error_outline,
          AppColor.red,
          AppColor.white,
        ).show(context);
      }
    }
  }
}
