import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_ostad/ui/state_managers/cancelled_task_controller.dart';
import 'package:task_manager_ostad/ui/widgets/screen_background.dart';
import 'package:task_manager_ostad/ui/widgets/task_list_tile.dart';
import 'package:task_manager_ostad/ui/widgets/user_profile_banner.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({Key? key}) : super(key: key);

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final CancelledTaskController _controller =
      Get.find<CancelledTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _controller.getCancelledTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileAppBar(),
            GetBuilder<CancelledTaskController>(builder: (_) {
              if (_controller.getCancelledTasksInProgress) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } /*else if (_controller.taskListModel.data!.isEmpty) {
                return const Expanded(
                  child: Center(
                    child: Text('No Data'),
                  ),
                );
              }*/
              return Expanded(
                child: ListView.separated(
                  itemCount: _controller.taskListModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskListTile(
                      data: _controller.taskListModel.data![index],
                      onDeleteTap: () {},
                      onEditTap: () {},
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 4,
                    );
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
