import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_ostad/ui/screens/splash_screen.dart';
import 'package:task_manager_ostad/ui/screens/update_task_status_sheet.dart';
import 'package:task_manager_ostad/ui/state_managers/add_new_task_controller.dart';
import 'package:task_manager_ostad/ui/state_managers/cancelled_task_controller.dart';
import 'package:task_manager_ostad/ui/state_managers/completed_task_controller.dart';
import 'package:task_manager_ostad/ui/state_managers/email_verification_controller.dart';
import 'package:task_manager_ostad/ui/state_managers/in_progress_controller.dart';
import 'package:task_manager_ostad/ui/state_managers/login_controller.dart';
import 'package:task_manager_ostad/ui/state_managers/new_screen_controller.dart';
import 'package:task_manager_ostad/ui/state_managers/otp_verification_controller.dart';
import 'package:task_manager_ostad/ui/state_managers/reset_password_controller.dart';
import 'package:task_manager_ostad/ui/state_managers/signup_controller.dart';
import 'package:task_manager_ostad/ui/state_managers/splash_screen_controller.dart';
import 'package:task_manager_ostad/ui/state_managers/summary_count_controller.dart';
import 'package:task_manager_ostad/ui/state_managers/update_profile_controller.dart';

class TaskManagerApp extends StatefulWidget {
  // static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  const TaskManagerApp({Key? key}) : super(key: key);

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // navigatorKey: TaskManagerApp.globalKey,
      title: 'Task Manager',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      themeMode: ThemeMode.light,
      initialBinding: ControllerBinding(),
      home: const SplashScreen(),
    );
  }
}

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
    Get.put<SummaryCountController>(SummaryCountController());
    Get.put<NewScreenController>(NewScreenController());
    Get.put<InProgressController>(InProgressController());
    Get.put<CancelledTaskController>(CancelledTaskController());
    Get.put<CompletedTaskController>(CompletedTaskController());
    Get.put(UpdateTaskStatusSheetGetX);
    Get.put<SignupController>(SignupController());
    Get.put<EmailVerificationController>(EmailVerificationController());
    Get.put<OtpVerificationController>(OtpVerificationController());
    Get.put<ResetPasswordController>(ResetPasswordController());
    Get.put<UpdateProfileController>(UpdateProfileController());
    Get.put<SplashScreenController>(SplashScreenController());
    Get.put<AddNewTaskController>(AddNewTaskController());
  }
}
