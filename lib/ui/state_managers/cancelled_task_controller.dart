import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class CancelledTaskController extends GetxController {
  bool _getCancelledTasksInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCancelledTasksInProgress => _getCancelledTasksInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCancelledTasks() async {
    _getCancelledTasksInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.cancelledTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);

      _getCancelledTasksInProgress = false;
      update();
      return true;
    } else {}
    _getCancelledTasksInProgress = false;
    update();

    return false;
  }
}
