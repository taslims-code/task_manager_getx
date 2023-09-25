import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class CompletedTaskController extends GetxController {
  bool _getCompletedTasksInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCompletedTasksInProgress => _getCompletedTasksInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCompletedTasks() async {
    _getCompletedTasksInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.completeTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);

      _getCompletedTasksInProgress = false;
      update();
      return true;
    } else {}
    _getCompletedTasksInProgress = false;
    update();

    return false;
  }
}
