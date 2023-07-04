import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/domain/models/task_model.dart';
import 'package:to_do_list/domain/models/user_model.dart';
import 'package:to_do_list/ui/task_detail_page/task_detail_page_view_model.dart';
import 'package:to_do_list/ui/task_detail_page/task_detail_stage_state.dart';

/// Widget that builds the detail task page.
class TaskDetailPage extends StatelessWidget {
  ///Constructor
  const TaskDetailPage({super.key});

  static const String route = '/addNewTask';

  /// Renders the TaskDetailPage as a widget.
  ///
  /// This method returns a ChangeNotifierProvider with a TaskDetailPageViewModel.
  static Widget render({TaskModel? task, bool? isEditeMode}) {
    return ChangeNotifierProvider(
      create: (context) => TaskDetailPageViewModel(context: context, task: task, isAdd: isEditeMode),
      lazy: false,
      child: TaskDetailPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TaskDetailPageViewModel taskDetailPageViewModel = context.read<TaskDetailPageViewModel>();
    final TaskDetailPageState state = context.select((TaskDetailPageViewModel viewModel) => viewModel.state);
    return Form(
      key: taskDetailPageViewModel.formKey,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16),
                  child: state.isEditMode
                      ? Text(
                          'Update task',
                          style: Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(color: Colors.white)),
                        )
                      : Text(
                          'Create new task',
                          style: Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(color: Colors.white)),
                        ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(left: 12),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 30, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.merge(const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null;
                            },
                            controller: taskDetailPageViewModel.titleEditingController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              hintText: 'Title',
                              border: UnderlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 30, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.merge(const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null;
                            },
                            controller: taskDetailPageViewModel.descriptionEditingController,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              hintText: 'Description',
                              border: UnderlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 30, 12),
                      child: Text(
                        'Task setup',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.merge(const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      onTap: taskDetailPageViewModel.saveCreatedDate,
                      controller: taskDetailPageViewModel.createDateEditingController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        labelText: 'Enter creation date',
                        icon: Icon(Icons.calendar_month_rounded),
                        border: UnderlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      controller: taskDetailPageViewModel.deadlineEditingController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        border: UnderlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                        labelText: 'Select deadline',
                        icon: Icon(Icons.access_time_rounded),
                      ),
                      onTap: taskDetailPageViewModel.saveDeadLine,
                    ),
                    DropdownButtonFormField<Priority>(
                      value: state.currentPriority,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        border: UnderlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                        icon: Icon(Icons.label),
                      ),
                      hint: const Text('Select priority'),
                      onChanged: (newPriority) {
                        taskDetailPageViewModel.setPriority(priority: newPriority);
                      },
                      items: Priority.values.map((Priority priority) {
                        return DropdownMenuItem<Priority>(
                          value: priority,
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: taskDetailPageViewModel.getPriorityColor(priority: priority),
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(priority.name),
                            ],
                          ),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value == Priority.none) {
                          return "Please enter some text";
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<UserModel>(
                      validator: (value) {
                        if (value == null) {
                          return "Please enter some text";
                        }
                        return null;
                      },
                      value: state.currentUser,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        border: UnderlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                        icon: Icon(Icons.person),
                      ),
                      onChanged: (newCreator) {
                        taskDetailPageViewModel.setCreator(creator: newCreator);
                      },
                      hint: const Text('Select creator'),
                      items: state.users.map((UserModel user) {
                        return DropdownMenuItem<UserModel>(
                          value: user,
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 38,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                ),
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.grey,
                                  child: Text(
                                    user.name[0],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(user.name + " " + user.surname),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: FilledButton(
                    onPressed: () async {
                      if (!taskDetailPageViewModel.formKey.currentState!.validate()) return;
                      if (state.isEditMode)  {await taskDetailPageViewModel.setUpdateTask();
                        return;};
                      await taskDetailPageViewModel.setSaveTask();
                    },
                    child: state.isPending
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : state.isEditMode
                            ? const Text('Update task')
                            : const Text('Save task'),
                  ),
                ),
              ),
              //child: Text("Save task")),
            ],
          ),
        ),
      ),
    );
  }
}
