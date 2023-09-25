import 'package:get/get.dart';
import 'package:task_manager_ostad/data/models/auth_utility.dart';
import 'package:task_manager_ostad/ui/screens/auth/login_screen.dart';
import 'package:task_manager_ostad/ui/screens/bottom_nav_base_screen.dart';

class SplashScreenController extends GetxController {
  Future<void> navigateToLogin() async {
    // await Future.delayed(Duration(seconds: 4));
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => const LoginScreen()),
    //       (route) => false,
    // );
    Future.delayed(const Duration(seconds: 3)).then((_) async {
      final bool isLoggedIn = await AuthUtility.checkIfUserLoggedIn();

      Get.offAll(
        () => isLoggedIn ? const BottomNavBaseScreen() : const LoginScreen(),
      );
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) =>
      //   isLoggedIn
      //       ? const BottomNavBaseScreen()
      //       : const LoginScreen()),
      //       (route) => false,
      // );
    });
  }
}
