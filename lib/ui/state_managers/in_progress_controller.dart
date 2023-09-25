import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class InProgressController extends GetxController {
  bool _getProgressTasksInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getProgressTasksInProgress => _getProgressTasksInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getInProgressTasks() async {
    _getProgressTasksInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.inProgressTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);

      _getProgressTasksInProgress = false;
      update();
      return true;
    } else {}
    _getProgressTasksInProgress = false;
    update();

    return false;
  }
}
