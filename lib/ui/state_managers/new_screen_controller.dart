import 'package:get/get.dart';
import 'package:task_manager_ostad/data/models/task_list_model.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class NewScreenController extends GetxController {
  bool _getNewTaskInProgress = false;
  String message = '';

  TaskListModel _taskListModel = TaskListModel();

  bool get getNewTaskInProgress => _getNewTaskInProgress;

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getNewTasks() async {
    _getNewTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      _getNewTaskInProgress = false;
      update();
      return true;
    } else {
      _getNewTaskInProgress = false;

      message = 'Data failed to load! Try again.';
      update();
      return false;
    }
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteTask(taskId));
    if (response.isSuccess) {
      _taskListModel.data!.removeWhere((element) => element.sId == taskId);
      update();
    } else {
      // Get.snackbar('title', message);
      // SnackBar(content: Text('Deletion of task has been failed')));
    }
  }

  Future<bool> editTask(String taskId, String status) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.updateTask(taskId, status));
    if (response.isSuccess) {
      print(true);
      return true;
    } else {
      return false;
    }
  }
}
