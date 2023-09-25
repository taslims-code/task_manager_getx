import 'package:get/get.dart';
import 'package:task_manager_ostad/data/models/network_response.dart';
import 'package:task_manager_ostad/data/services/network_caller.dart';
import 'package:task_manager_ostad/data/utils/urls.dart';

class AddNewTaskController extends GetxController {
  bool _adNewTaskInProgress = false;

  bool get adNewTaskInProgress => _adNewTaskInProgress;

  Future<void> addNewTask(String title, description) async {
    _adNewTaskInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "title": title.trim(),
      "description": description.trim(),
      "status": "New"
    };
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.createTask, requestBody);
    _adNewTaskInProgress = false;
    update();
    if (response.isSuccess) {


      Get.snackbar('Successful', 'Task added successfully');
    } else {
      Get.snackbar('Failed', 'Task add failed!');

    }
  }
}
