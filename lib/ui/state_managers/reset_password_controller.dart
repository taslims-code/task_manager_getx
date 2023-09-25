import 'package:get/get.dart';
import 'package:task_manager_ostad/data/models/network_response.dart';
import 'package:task_manager_ostad/data/services/network_caller.dart';
import 'package:task_manager_ostad/data/utils/urls.dart';
import 'package:task_manager_ostad/ui/screens/auth/login_screen.dart';

class ResetPasswordController extends GetxController {
  bool _setPasswordInProgress = false;

  bool get setPasswordInProgress => _setPasswordInProgress;

  Future<void> resetPassword(String email, otp, password) async {
    _setPasswordInProgress = true;
    update();

    final Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": password,
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.resetPassword, requestBody);
    _setPasswordInProgress = false;
    update();
    if (response.isSuccess) {
      Get.snackbar('Success', 'Password reset successful!');
      Get.offAll(() => const LoginScreen());
      /*if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password reset successful!')));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      }*/
    } else {
      Get.snackbar('Failed', 'Failed to reset password!');
      /*if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reset password has been failed!')));
      }*/
    }
  }
}
