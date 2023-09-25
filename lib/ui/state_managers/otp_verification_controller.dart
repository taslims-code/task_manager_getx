import 'package:get/get.dart';
import 'package:task_manager_ostad/data/services/network_caller.dart';
import 'package:task_manager_ostad/data/utils/urls.dart';
import 'package:task_manager_ostad/ui/screens/auth/reset_password_screen.dart';

import '../../data/models/network_response.dart';

class OtpVerificationController extends GetxController {
  bool _otpVerificationInProgress = false;

  bool get otpVerificationInProgress => _otpVerificationInProgress;

  Future<void> verifyOTP(String email, otp) async {
    _otpVerificationInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.otpVerify(email, otp));
    _otpVerificationInProgress = false;
    update();
    if (response.isSuccess) {
      Get.to(() => ResetPasswordScreen(email: email, otp: otp));
      /* if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPasswordScreen(
                      email: widget.email,
                      otp: _otpTEController.text,
                    )));
      }*/
    } else {
      Get.snackbar('Failed', 'Something went wrong. Try again!');
      /* if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Otp verification has been failed!')));
      }*/
    }
  }
}
