import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskStatusUpdaterBottomSheet extends StatelessWidget {
  const TaskStatusUpdaterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return bottomSheet();
  }

  bottomSheet() {
    return Get.bottomSheet(Container());
  }
}
