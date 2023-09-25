import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_ostad/ui/state_managers/completed_task_controller.dart';
import 'package:task_manager_ostad/ui/widgets/screen_background.dart';
import 'package:task_manager_ostad/ui/widgets/task_list_tile.dart';
import 'package:task_manager_ostad/ui/widgets/user_profile_banner.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompletedTaskController _controller =
      Get.find<CompletedTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _controller.getCompletedTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileAppBar(),
            GetBuilder<CompletedTaskController>(builder: (_) {
              if (_controller.getCompletedTasksInProgress) {
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
              else {
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
              }
            })
          ],
        ),
      ),
    );
  }
}
