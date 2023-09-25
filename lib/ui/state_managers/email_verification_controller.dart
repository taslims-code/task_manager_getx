import 'package:get/get.dart';
import 'package:task_manager_ostad/data/services/network_caller.dart';
import 'package:task_manager_ostad/data/utils/urls.dart';
import 'package:task_manager_ostad/ui/screens/auth/otp_verification_screen.dart';

import '../../data/models/network_response.dart';

class EmailVerificationController extends GetxController {
  bool _emailVerificationInProgress = false;

  bool get emailVerificationInProgress => _emailVerificationInProgress;

  Future<bool> sendOTPToEmail(String email) async {
    _emailVerificationInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.sendOtpToEmail(email));
    _emailVerificationInProgress = false;
    update();
    if (response.isSuccess) {
      Get.to(() => OtpVerificationScreen(email: email));

      return true;
    } else {
      Get.snackbar('Failed', 'Something went wrong!');
      return false;
    }
  }
}
