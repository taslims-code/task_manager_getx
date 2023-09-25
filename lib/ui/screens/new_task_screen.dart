import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_ostad/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_ostad/ui/state_managers/new_screen_controller.dart';
import 'package:task_manager_ostad/ui/state_managers/summary_count_controller.dart';
import 'package:task_manager_ostad/ui/widgets/screen_background.dart';
import 'package:task_manager_ostad/ui/widgets/summary_card.dart';
import 'package:task_manager_ostad/ui/widgets/task_list_tile.dart';
import 'package:task_manager_ostad/ui/widgets/user_profile_banner.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final SummaryCountController _summaryCountController =
      Get.find<SummaryCountController>();
  final NewScreenController _newScreenController =
      Get.find<NewScreenController>();

  final List _statusList = ['New', 'Completed', 'Cancelled', 'Progress'];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _summaryCountController.getCountSummary();
      await _newScreenController.getNewTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileAppBar(),
            GetBuilder<SummaryCountController>(builder: (_) {
              if (_summaryCountController.getCountSummaryInProgress) {
                return const Center(
                  child: LinearProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _summaryCountController
                            .summaryCountModel.data?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return SummaryCard(
                        title: _summaryCountController
                                .summaryCountModel.data![index].sId ??
                            'New',
                        number: _summaryCountController
                                .summaryCountModel.data![index].sum ??
                            0,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 4,
                      );
                    },
                  ),
                ),
              );
            }),
            GetBuilder<NewScreenController>(builder: (_) {
              if (_newScreenController.getNewTaskInProgress) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await _newScreenController.getNewTasks();
                    await _summaryCountController.getCountSummary();
                  },
                  child: ListView.separated(
                    itemCount:
                        _newScreenController.taskListModel.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskListTile(
                        data: _newScreenController.taskListModel.data![index],
                        onDeleteTap: () {
                          _newScreenController.deleteTask(_newScreenController
                              .taskListModel.data![index].sId!);
                        },
                        onEditTap: () {
                          var taskId = _newScreenController
                              .taskListModel.data![index].sId!;
                          Get.bottomSheet(Container(
                            decoration: const BoxDecoration(
                              color: Colors.red,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Select Task Status',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                ListView.builder(
                                  itemCount: 4,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var taskStatus = _statusList[index];
                                    return ListTile(
                                      title: Text(_statusList[index]),
                                      onTap: () {
                                        _newScreenController.editTask(
                                            taskId, taskStatus);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ));
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 4,
                      );
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewTaskScreen()));
        },
      ),
    );
  }
}
