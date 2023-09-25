import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class UpdateTaskStatusSheetGetX extends GetxController {
  TaskData task;
  VoidCallback onUpdate;

  UpdateTaskStatusSheetGetX({required this.task, required this.onUpdate});

  List<String> taskStatusList = ['New', 'Progress', 'Canceled', 'Completed'];

  String get selectedTask => _selectedTask;
  String _selectedTask = '';

  @override
  void onInit() {
    super.onInit();
    _selectedTask = task.status!.toLowerCase();
  }

  bool updateTaskInProgress = false;
  String message = '';

  Future<void> updateTask(String taskId, String newStatus) async {
    updateTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.updateTask(taskId, newStatus));
    updateTaskInProgress = false;
    update();
    if (response.isSuccess) {
      onUpdate();
      Get.back();
    } else {
      message = 'Failed to update task status!';
    }
  }
}
