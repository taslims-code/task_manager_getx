import 'package:get/get.dart';
import 'package:task_manager_ostad/data/models/network_response.dart';
import 'package:task_manager_ostad/data/services/network_caller.dart';
import 'package:task_manager_ostad/data/utils/urls.dart';
import 'package:task_manager_ostad/ui/screens/auth/login_screen.dart';

class SignupController extends GetxController {
  bool _signUpInProgress = false;

  bool get signUpInProgress => _signUpInProgress;

  Future<bool> userSignUp(
      String email, firstName, lastName, mobile, password, photo) async {
    _signUpInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": photo,
    };

    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.registration,
      requestBody,
    );

    if (response.isSuccess) {
      Get.snackbar('Success', 'Registration Success!');
      Get.offAll(() => const LoginScreen());
      _signUpInProgress = false;
      update();
      return true;
    } else {
      Get.snackbar('Failed', 'Registration failed!');
      return false;
    }
  }
}
