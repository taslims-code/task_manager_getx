import 'package:get/get.dart';
import 'package:task_manager_ostad/data/models/auth_utility.dart';
import 'package:task_manager_ostad/data/models/login_model.dart';
import 'package:task_manager_ostad/data/models/network_response.dart';
import 'package:task_manager_ostad/data/services/network_caller.dart';
import 'package:task_manager_ostad/data/utils/urls.dart';

class UpdateProfileController extends GetxController {
  bool _profileInProgress = false;

  bool get profileInProgress => _profileInProgress;
  UserData? userData = AuthUtility.userInfo.data;

  Future<void> updateProfile(
      String firstName, lastName, mobile, photo, password) async {
    _profileInProgress = true;
    update();
    final Map<String, dynamic> requestBody = {
      "firstName": firstName.trim(),
      "lastName": lastName.trim(),
      "mobile": mobile.trim(),
      "photo": photo,
    };
    if (password.text.isNotEmpty) {
      requestBody['password'] = password.text;
    }

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.updateProfile, requestBody);
    _profileInProgress = false;
    update();
    if (response.isSuccess) {
      userData?.firstName = firstName.trim();
      userData?.lastName = lastName.trim();
      userData?.mobile = mobile.trim();
      AuthUtility.updateUserInfo(userData!);
      password.clear();

      Get.snackbar('Successful', 'Profile successfully updated!');
      /*if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Profile updated!')));
      }*/
    } else {
      Get.snackbar('Failed', 'Something went wrong!');
      /*if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile update failed! Try again.')));
      }*/
    }
  }
}
